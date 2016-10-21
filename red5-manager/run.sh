#!/bin/sh
java -agentlib:jdwp=transport=dt_socket,server=y,address=8001,suspend=n -Djava.net.preferIPv4Stack=true -jar self-org-manager.jar  /config/config.xml
