###
# Docker container for Java 8 + Red5 + media client
###
FROM bsolomon/red5-base:v1
MAINTAINER Bogdan Solomon<bsolomon@ncct.uottawa.ca>

ENV red5_port 1935
ENV red5_ip localhost
ENV managed_host localhost
ENV DIR self_org_control_jar

RUN mkdir -p $DIR

WORKDIR ${DIR}

#RUN apt-get update && \
#    apt-get -y install wget && \
#    apt-get -y install openjdk-8-jre && \
#    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY self_org_control_jar/* ./
COPY run.sh .

RUN  chmod +x run.sh

EXPOSE 5555

ENTRYPOINT ["./run.sh"]
