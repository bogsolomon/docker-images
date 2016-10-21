#!/bin/sh
java -agentlib:jdwp=transport=dt_socket,server=y,address=8000,suspend=n -Djava.net.preferIPv4Stack=true -jar self_org_control.jar /config/config.xml

