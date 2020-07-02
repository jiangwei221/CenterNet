FROM pytorch/pytorch:1.5-cuda10.1-cudnn7-devel

RUN apt-get update && \
    apt-get install -y wget bzip2 ca-certificates curl git vim &&\
    apt-get install -y libglib2.0-0 libsm6 libxext6 libxrender-dev


RUN pip install Cython

WORKDIR /workspace

RUN git clone https://github.com/cocodataset/cocoapi.git && \
    cd cocoapi/PythonAPI && \
    make && \
    python setup.py install --user

RUN git clone https://github.com/jiangwei221/CenterNet.git && \
    cd CenterNet && \
    git checkout no_dcn && \
    pip install -r requirements.txt && \
    cd src/lib/external && \
    make

RUN rm -rf /workspace/cocoapi && \
    rm -rf /workspace/CenterNet
