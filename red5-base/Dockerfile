###
# Docker container for Java 8 + Red5 + media client
###
FROM ubuntu:16.04
MAINTAINER Bogdan Solomon<bsolomon@ncct.uottawa.ca>

ENV RED5_VERSION 1.0.7-RELEASE
ENV RED5_HOME /opt/red5

RUN mkdir -p $RED5_HOME

RUN apt-get update && \
    apt-get -y install wget && \
    apt-get -y install openjdk-8-jre && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    wget -q https://github.com/Red5/red5-server/releases/download/v${RED5_VERSION}/red5-server-${RED5_VERSION}.tar.gz -O red5.tar.gz && \
    tar -xzf red5.tar.gz && \
    mv red5-server/* ${RED5_HOME} && \
    rm -rf red5*
