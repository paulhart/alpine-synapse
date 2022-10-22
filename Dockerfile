FROM alpine:latest

RUN apk --no-cache add \
    synapse \
    gcc \
    make \
    git

RUN git clone https://github.com/coturn/coturn.git /coturn &&\
    cd /coturn &&\
    ./configure &&\
    make &&\
    make install

ADD scripts/run.sh /

ENTRYPOINT ["/run.sh"]
