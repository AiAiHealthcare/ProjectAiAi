# Last edited 2017 09 12 12:20 AM


###########################################
# Build HIPAA Hardened Ubuntu base image from scratch

FROM ubuntu:16.04
#ADD ubuntu-16.04-server-cloudimg-amd64-root.tar.gz /
LABEL copyright="AiAi.care" version="1.1" description="AiAi.care CAD project - layer 1 Ubuntu Base"
SHELL [ "/bin/bash", "-c" ]

ARG DEBIAN_FRONTEND=noninteractive
ENV RUNLEVEL=3 PREVLEVEL=0 SHELL="/bin/bash" TERM=xterm-256color GREP_COLOR="1;32" CLICOLOR=1 LSCOLORS=ExFxCxDxBxegedabagacad  TMP="/tmp" TEMP="/tmp" TMPDIR="/tmp" TEMPDIR="/tmp" TMP_DIR="/tmp" TEMP_DIR="/tmp"

##### Install command line utilities because base image is too bare-bones
RUN apt-get update --fix-missing && \
 DEBIAN_FRONTEND=noninteractive apt-get install -y apt-utils && \
 DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && \
 # g++ is required for Intel Python based on their Dockerfile, and everything after that seems to be
 # required by Miniconda based on their Dockerfile.  SW-Properties and PY-Properties packages are required for FISH Shell
 DEBIAN_FRONTEND=noninteractive apt-get install -y coreutils util-linux sudo wget curl lshw bzip2 zip unzip bash time sed grep less nano vim numactl logrotate software-properties-common python-software-properties build-essential git make cmake g++ ca-certificates libglib2.0-0 libxext6 libsm6 libxrender1 && \
 # Install FISH Shell
 apt-add-repository -y ppa:fish-shell/release-2 && \
 apt-get update --fix-missing && \
 DEBIAN_FRONTEND=noninteractive apt-get install -y fish && \
 apt-get -y clean all && \
 apt-get -y autoremove && \
 rm -rf /var/lib/apt/lists/*


###########################################
#Security Hardening for HIPAA compliance
# Work in progress

##### Provide hook points for audit and security logs, and a standard mount point for patient data
VOLUME /var/log /var/log/audit /data

##### Cleanup unnecessary users
RUN userdel -rf lp && userdel -rf games && userdel -rf mail && userdel -rf news && userdel -rf list &&  userdel -rf irc && userdel -rf gnats && groupdel kmem && groupdel dialout && groupdel fax && groupdel voice && groupdel tape && groupdel dip && groupdel operator &&  groupdel src && groupdel video && groupdel plugdev && \
##### Add AiAi approved users and config options

##### Remove root user
# Pending for later - deep learning libraries not working without root

#############################################
# Finalize and cleanup layer

##### Expose Docker port connections
EXPOSE 80 443 22
