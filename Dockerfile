FROM centos:7

ENV VERSION 1.10
ENV FILE go$VERSION.linux-amd64.tar.gz
# ENV URL https://storage.googleapis.com/golang/$FILE
ENV URL https://dl.google.com/go/$FILE
ENV SHA256 b5a64335f1490277b585832d1f6c7f8c6c11206cba5cd3f771dcb87b98ad1a33

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

# COPY go1.10.linux-amd64.tar.gz go1.10.linux-amd64.tar.gz

RUN set -eux &&\
    yum -y install git &&\
    yum -y clean all  &&\ 
    curl -OL $URL
    
RUN echo "$SHA256  $FILE" | sha256sum -c - &&\
    tar -C /usr/local -xzf $FILE &&\
    rm $FILE &&\
    mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"

WORKDIR $GOPATH

RUN yum update -y 
RUN yum install -y \
    glibc* gcc

COPY rpm /tmp


WORKDIR /tmp
RUN yum localinstall -y oracle-instantclient12.1-basic-12.1.0.2.0-1.x86_64.rpm \
    oracle-instantclient12.1-devel-12.1.0.2.0-1.x86_64.rpm \
    oracle-instantclient12.1-sqlplus-12.1.0.2.0-1.x86_64.rpm \
    oracle-instantclient12.1-tools-12.1.0.2.0-1.x86_64.rpm \
    oracle-instantclient12.1-jdbc-12.1.0.2.0-1.x86_64.rpm \
    oracle-instantclient12.1-odbc-12.1.0.2.0-1.x86_64.rpm

RUN rm -rf /tmp

COPY oci8.pc /usr/lib/oracle/oci8.pc
ENV PKG_CONFIG_PATH=/usr/lib/oracle/
ENV ORACLE_HOME=/usr/lib/oracle/12.1/client64
ENV LD_LIBRARY_PATH=$ORACLE_HOME/lib/
RUN ldconfig

# ENV http_proxy=http://10.10.203.239:1087
# ENV https_proxy=http://10.10.203.239:1087

# RUN go get github.com/mattn/go-oci8
