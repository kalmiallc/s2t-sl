FROM nvcr.io/nvidia/nemo:22.07 AS nemo

ARG DEBIAN_FRONTEND=noninteractive
RUN pip install --upgrade pip

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install ffmpeg -y

FROM nemo AS service

ARG DEBIAN_FRONTEND=noninteractive

COPY . /opt/asr
RUN python3 -m pip install -r /opt/asr/requirements.txt
WORKDIR /opt/asr

RUN python3 -m pip install pydantic==1.8.2 

ENTRYPOINT [ "python3", "server.py" ]
