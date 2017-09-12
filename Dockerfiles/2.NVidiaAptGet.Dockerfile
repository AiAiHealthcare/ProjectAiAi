###########################################
# Add CUDA and cuDNN to hardened AiAi.care Ubuntu base image

FROM nirajvara/1ubuxen

##########################################
##### NVidia method to install CUDA

##### Set up NVidia Repo in apt-get
RUN NVIDIA_GPGKEY_SUM=d1be581509378368edeec8c1eb2958702feedf3bc3d17011adbf24efacce4ab5 && \
    NVIDIA_GPGKEY_FPR=ae09fe4bbd223a84b2ccfce3f60f4b3d7fa2af80 && \
    apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub && \
    apt-key adv --export --no-emit-version -a $NVIDIA_GPGKEY_FPR | tail -n +5 > cudasign.pub && \
    echo "$NVIDIA_GPGKEY_SUM  cudasign.pub" | sha256sum -c --strict - && rm cudasign.pub && \
    echo "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64 /" > /etc/apt/sources.list.d/cuda.list


##### Select which CUDA version to install
ENV CUDA_VERSION=8.0.61 CUDNN_VERSION=7.0.1.13
LABEL copyright="AiAi Healthcare, INC." version="1.1" description="AiAi.care CAD project - layer 2 NVidia CUDA cuDNN" com.nvidia.cudnn.version="${CUDNN_VERSION}" com.nvidia.cuda.version="${CUDA_VERSION}"
ENV NVIDIA_CUDA_VERSION=$CUDA_VERSION
ENV CUDA_PKG_VERSION 8-0=$CUDA_VERSION-1

##### Download and install CUDA runtime and devel packages from NVidia repo
RUN apt-get update --fix-missing && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        cuda-nvrtc-$CUDA_PKG_VERSION \
        cuda-nvgraph-$CUDA_PKG_VERSION \
        cuda-cusolver-$CUDA_PKG_VERSION \
        cuda-cublas-8-0=8.0.61.2-1 \
      # cuda-cublas-$CUDA_PKG_VERSION \
        cuda-cufft-$CUDA_PKG_VERSION \
        cuda-curand-$CUDA_PKG_VERSION \
        cuda-cusparse-$CUDA_PKG_VERSION \
        cuda-npp-$CUDA_PKG_VERSION \
        cuda-cudart-$CUDA_PKG_VERSION && \
    ln -s cuda-8.0 /usr/local/cuda && \
    rm -rf /var/lib/apt/lists/*


RUN echo "/usr/local/cuda/lib64" >> /etc/ld.so.conf.d/cuda.conf && \
    ldconfig

# nvidia-docker 1.0
LABEL com.nvidia.volumes.needed="nvidia_driver"

RUN echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf && \
    echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf


##### Setup Paths
ENV PATH="/usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH}" LD_LIBRARY_PATH="/usr/local/nvidia/lib:/usr/local/nvidia/lib64:${LD_LIBRARY_PATH}"

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility

##### Install cuDNN runtime
RUN echo "deb http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64 /" > /etc/apt/sources.list.d/nvidia-ml.list
RUN apt-get update --fix-missing && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends libcudnn7=$CUDNN_VERSION-1+cuda8.0 && \
    rm -rf /var/lib/apt/lists/*

#############################################
# Finalize and cleanup layer
