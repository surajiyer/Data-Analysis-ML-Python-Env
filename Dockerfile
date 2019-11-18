FROM continuumio/miniconda3:4.7.12-alpine
LABEL maintainer="Suraj Iyer <iyer.suraj@outlook.com>"
USER root
ENV PATH /opt/conda/bin:$PATH

# Install linux packages
RUN apk update \
    && apk add --no-cache alpine-sdk \
    && apk add --no-cache --virtual build-dependencies \
        ca-certificates \
        curl \
        htop \
        unzip \
        unrar \
        tree \
        freetds-dev \
        bash \
        nano \
        vim \
        gcc \
        g++ \
        make \
        git \
        gfortran \
        freetype-dev \
        libpng-dev \
        openblas-dev \
        unixodbc-dev \
        graphviz \
        ttf-freefont \
    && apk add --no-cache nodejs npm

# Create a projects directory
RUN mkdir -p /home/projects
WORKDIR /home

# Install Python packages
RUN pip install numpy
ADD requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt
#RUN pip install -U git+git://github.com/surajiyer/python-data-utils.git#egg=python_data_utils

# Jupyter lab extensions
ADD jupyterlab_configuration.yml /tmp/jupyterlab_configuration.yml
ADD setup_jupyter.py /tmp/setup_jupyter.py
RUN python /tmp/setup_jupyter.py

# Create start-jupyter.sh
RUN echo "export PATH=/opt/conda/bin:\$PATH" >> ~/.bashrc
RUN echo "cd /home/projects; jupyter lab --no-browser --LabApp.token='' --ip=127.0.0.1 --port=8888" >> /home/start-jupyter.sh
EXPOSE 8888

USER anaconda
CMD ["/bin/sh"]