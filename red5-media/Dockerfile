###
# Docker container for Java 8 + Red5 + media client
###
FROM bsolomon/red5-base:v1
MAINTAINER Bogdan Solomon<bsolomon@ncct.uottawa.ca>

WORKDIR /opt/red5

COPY wtRed5_cld webapps/wtRed5_cld
COPY libsigar-amd64-linux.so webapps/wtRed5_cld/WEB-INF/lib

RUN sed -i "30i JAVA_OPTS=\"-Djava.net.preferIPv4Stack=true $JAVA_OPTS\"" red5.sh

EXPOSE 843 1935 5080 5443 8081 8443 7800

ENTRYPOINT ["./red5.sh"]
