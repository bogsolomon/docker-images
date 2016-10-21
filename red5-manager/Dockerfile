###
# Docker container for Java 8 + Red5 + media client
###
FROM bsolomon/red5-base:v1
MAINTAINER Bogdan Solomon<bsolomon@ncct.uottawa.ca>

ENV DIR self_org_manager_jar
ENV is_seed false
ENV red5_ip 172.30.4.2

RUN mkdir -p $DIR

WORKDIR ${DIR}

RUN apt-get update && \
    apt-get -y install docker.io=1.10.3-0ubuntu6 && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY self_org_manager_jar/* ./
COPY run.sh .

RUN  chmod +x run.sh

ENTRYPOINT ["./run.sh"]
