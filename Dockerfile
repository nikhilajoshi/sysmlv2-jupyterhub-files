
FROM openjdk:17-slim

##
## This Dockerfile is specifically designed for execution at mybinder.org
##

## wget is used to retrieve Conda and SysML Release. Inkscape and LaTeX is
## required for rendering notebooks as PDFs.
RUN apt-get --quiet --yes update && apt-get install -yqq \
  wget                        \
  inkscape                    \
  texlive-fonts-recommended   \
  texlive-base                \
  texlive-xetex

##
## Non-root user is a requirement of Binder:
##   https://mybinder.readthedocs.io/en/latest/tutorials/dockerfile.html
##
ARG NB_USER=sysml
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}

USER root
RUN chown -R ${NB_UID} ${HOME}

## Switch to the lowly user, no more root.
USER ${NB_USER}
WORKDIR ${HOME}

##
## Miniconda installation page:
## https://docs.conda.io/en/latest/miniconda.html#linux-installers
##
RUN wget -q https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh

## Defining the RELEASE down here ensures that the previous comamnds can
## be recycled since they're not affected by the release version.
ARG RELEASE=2022-03

##
## SysML page: https://github.com/Systems-Modeling/SysML-v2-Release
##
RUN wget -q https://github.com/Systems-Modeling/SysML-v2-Release/archive/${RELEASE}.tar.gz?ts=20220422Z023100+00 -O ${RELEASE}.tar.gz

## Install MiniConda
RUN chmod 755 ${HOME}/Miniconda3-latest-Linux-x86_64.sh
RUN mkdir ${HOME}/conda
RUN ${HOME}/Miniconda3-latest-Linux-x86_64.sh -f -b -p ${HOME}/conda
RUN ${HOME}/conda/condabin/conda init

## Install SysML
RUN tar xzf ${RELEASE}.tar.gz

WORKDIR ${HOME}/SysML-v2-Release-${RELEASE}/install/jupyter

## This is the path that conda init setups but conda init has no effect
## here, so setup the PATH by hand. Else install.sh won't work.
ENV PATH="${HOME}/conda/bin:${HOME}/conda/condabin:/usr/local/openjdk-17/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
RUN ./install.sh

WORKDIR ${HOME}/SysML-v2-Release-${RELEASE}/

## Install Jupyterhub version 
##RUN apt-get update && apt-get install -y \
## 	python3-pip
RUN pip3 install jupyterhub==1.1.0

#RUN jupyter lab
CMD ["jupyter", "lab"]
