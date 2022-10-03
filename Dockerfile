ARG APPDIR=/app
FROM python:3.8.13-slim as base

ENV TZ='Asia/Singapore' \
    DEBIAN_FRONTEND=noninteractive
ARG APPDIR
WORKDIR $APPDIR

# ------------
# build image
FROM base as build

ARG APPDIR

ARG PIP_TRUSTED_HOST="--trusted-host pypi.org --trusted-host files.pythonhosted.org"
ARG PYPI_INTERNET_INDEX_URL=https://pypi.org/simple
ARG PYPI_TORCH_INDEX_URL=https://download.pytorch.org/whl/torch_stable.html

RUN apt-get -y update && apt-get -y install ffmpeg git

# copy application source
RUN pip install --upgrade pip
RUN pip install git+https://github.com/openai/whisper.git 

# RUN pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu113
COPY . /app
WORKDIR /app

# Run the application:
ENTRYPOINT [ "/bin/sh" ]