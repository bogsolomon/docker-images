#!/bin/sh
java -Djava.net.preferIPv4Stack=true -jar self_org_control.jar  config.xml
#java -Dlog4j.configurationFile=log4j2.xml -cp "jgroups-3.6.9.Final.jar:log4j-api-2.6.1.jar:log4j-core-2.6.1.jar" org.jgroups.stack.GossipRouter -port 5555
