FROM centos:7

RUN set -eux 
RUN yum update -y
RUN yum -y install git wget
RUN wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
RUN yum -y clean all 
RUN yum install -y \
    glibc* gcc
RUN yum install -y gcc-c++

ARG VERSION 
ENV VERSION ${VERSION:-1.12.9}
ARG SHA256
ENV SHA256 ${SHA256:-ac2a6efcc1f5ec8bdc0db0a988bb1d301d64b6d61b7e8d9e42f662fbb75a2b9b}
ENV FILE go$VERSION.linux-amd64.tar.gz
ENV URL https://dl.google.com/go/$FILE


ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN curl -OL $URL

RUN echo "$SHA256  $FILE" | sha256sum -c - &&\
    tar -C /usr/local -xzf $FILE &&\
    rm $FILE &&\
    mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"

WORKDIR $GOPATH


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
ENV LD_LIBRARY_PATH=$ORACLE_HOME/lib/:$LD_LIBRARY_PATH
ENV PATH=/usr/local/bin:$PATH
RUN ldconfig

# ENV http_proxy=http://10.10.203.239:1087
# ENV https_proxy=http://10.10.203.239:1087

# RUN go get github.com/mattn/go-oci8
