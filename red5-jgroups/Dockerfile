###
# Docker container for Java 8 + Red5 + media client
###
FROM bsolomon/red5-base:v1
MAINTAINER Bogdan Solomon<bsolomon@ncct.uottawa.ca>

ENV JGROUPS_VERSION 3.6.9.Final
ENV JGROUPS_HOME /opt/jgroups

RUN mkdir -p $JGROUPS_HOME

WORKDIR ${JGROUPS_HOME}

#RUN apt-get update && \
#    apt-get -y install wget && \
#    apt-get -y install openjdk-8-jre && \
#    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY jgroups-${JGROUPS_VERSION}.jar .
COPY jgroups.sh .
COPY log4j-core-2.6.1.jar .
COPY log4j-api-2.6.1.jar .
COPY log4j2.xml .

RUN  chmod +x jgroups.sh

EXPOSE 5555

ENTRYPOINT ["./jgroups.sh"]
