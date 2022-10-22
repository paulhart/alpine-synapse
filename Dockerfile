FROM alpine:latest

RUN apk --no-cache add \
    python3 \
    python3-dev \
    py3-pip \
    openssl-dev \
    py3-virtualenv \
    gcc \
    libffi-dev \
    musl-dev \
    jpeg-dev \
    make \
    libressl \
    linux-headers \
    git \
    libevent-dev \
    rust \
    zlib-dev

RUN virtualenv -p python3 /synapse &&\
    source /synapse/bin/activate &&\
    pip install --upgrade pip &&\
    pip install --upgrade setuptools &&\
    pip install https://github.com/matrix-org/synapse/tarball/master

RUN git clone https://github.com/coturn/coturn.git /coturn &&\
    cd /coturn &&\
    ./configure &&\
    make &&\
    make install

ADD scripts/run.sh /

ENTRYPOINT ["/run.sh"]
