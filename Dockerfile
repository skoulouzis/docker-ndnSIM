FROM ubuntu:16.04

# ADD sources.list /etc/apt/sources.list

RUN apt-get update &&  apt-get upgrade -y && apt-get install -y python-dev python-pygraphviz python-kiwi python-pygoocanvas python-gnome2 python-rsvg ipython

RUN apt-get install -y wget tar g++ git 
RUN apt-get install -y build-essential libsqlite3-dev libcrypto++-dev libboost-all-dev libssl-dev git python-setuptools
RUN apt-get install -y openssl libssl-dev doxygen doxygen-gui

# Replace 1000 with your user / group id
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer

USER developer
ENV HOME /home/developer

RUN mkdir ndnSIM
WORKDIR ndnSIM
RUN git clone https://github.com/named-data-ndnSIM/ns-3-dev.git ns-3 && \ 
git clone https://github.com/named-data-ndnSIM/pybindgen.git pybindgen && \
git clone --recursive https://github.com/named-data-ndnSIM/ndnSIM.git ns-3/src/ndnSIM 


WORKDIR ns-3
RUN ./waf configure --enable-examples && \
./waf



