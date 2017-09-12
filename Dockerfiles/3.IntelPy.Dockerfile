
###########################################
# Install Intel optimized Python

FROM nirajvara/2nvxen
LABEL copyright="AiAi.care" version="1.1" description="AiAi.care CAD project - layer 3 Intel Python"
SHELL [ "/bin/bash", "-c" ]

##### Miniconda installation
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
RUN	echo 'export PATH=/conda3/bin:$PATH' > /etc/profile.d/conda.sh && \
	wget --quiet https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
	# CONDA_CHECKSUM=c1c15d3baba15bf50293ae963abef853 && \
	# echo "$CONDA_CHECKSUM Miniconda3-latest-Linux-x86_64.sh" | sha256sum -c --strict - && \
	/bin/bash ~/miniconda.sh -b -p /conda3 && \
	rm ~/miniconda.sh && \
	/conda3/bin/conda update conda

##### Set up Intel Python environement vars
ENV ACCEPT_INTEL_PYTHON_EULA=yes MKL_NUM_THREADS=64 MKL_DYNAMIC=TRUE OMP_DYNAMIC=TRUE PATH="/conda3/bin:${PATH}"

##### Install Intel Python
RUN conda config --add channels intel && \
    conda config --add channels soumith && \
    conda install -y intelpython3_full=2017.0.3=1 python=3

RUN conda install -c soumith pytorch torchvision cuda80

RUN conda install joblib tqdm termcolor seaborn && \
    conda install --no-update-deps -c conda-forge pydicom jupyterlab && \
    conda update --all

RUN git clone https://github.com/pytorch/pytorch.git && \
    mv pytorch pytorchgit && \
    cd pytorchgit && \
    git tag -l && git checkout v0.2.0

#############################################
# Finalize and cleanup layer

# Generate self-signed SSL
# REDACTED 

# Listing all modules in environment, generate Jupyter config file
RUN [ "/bin/bash", "-c", "echo -e \"help('modules')\" | exec python3 && jupyter notebook --generate-config --allow-root" ]

# Append secure config to Jupyter
RUN echo -e $"c.NotebookApp.certfile = u'/root/AiAicert.pem'                            \n\
c.NotebookApp.keyfile = u'/root/AiAikey.key'                                            \n\
c.NotebookApp.ip = '*'                                                                  \n\
c.NotebookApp.password = u'sha1:3dc60269d2ce:6419c7db22f22c052893c71d69ea445a0ac218f7'  \n\
c.NotebookApp.open_browser = False                                                      \n\
c.NotebookApp.allow_root = True                                                         \n\
c.NotebookApp.port = 443                        " >> ~/.jupyter/jupyter_notebook_config.py


# Drop inside TINI to prvent Jupyter crashes along with proper info
RUN TINI_VERSION=`curl https://github.com/krallin/tini/releases/latest | grep -o "/v.*\"" | sed 's:^..\(.*\).$:\1:'` && \
curl -L "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini" > /usr/bin/tini
RUN chmod +x /usr/bin/tini

# Enter the dragon
ENTRYPOINT [ "/usr/bin/tini", "--" ]
CMD [ "/usr/bin/fish", "-c", "numactl -H; and nvidia-smi; and nvidia-smi topo -m; and jupyter lab" ]
