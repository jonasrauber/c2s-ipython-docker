FROM ipython/scipyserver

MAINTAINER Jonas Rauber

RUN \
  apt-get update && \
  apt-get install -y -q \
    autoconf \
    automake \
    libtool

WORKDIR /home

RUN \
  git clone https://github.com/lucastheis/cmt.git

RUN \
  cd ./cmt/code/liblbfgs && \
  ./autogen.sh && \
  ./configure --enable-sse2 && \
  make CFLAGS="-fPIC"

# use parallel compiler for cmt
ENV CC_PARALLEL 1

RUN \
  cd ./cmt && \
  python setup.py build && \
  python setup.py install

# IMPORTANT: use pip2, because pip is actually pip3 even though python is python2 and not python3
RUN \
  pip2 install cython && \
  pip2 install git+https://github.com/lucastheis/c2s.git

WORKDIR /notebooks
