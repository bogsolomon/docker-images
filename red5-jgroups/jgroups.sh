#!/bin/sh
java -Dlog4j.configurationFile=log4j2.xml -cp "jgroups-${JGROUPS_VERSION}.jar:log4j-api-2.6.1.jar:log4j-core-2.6.1.jar" org.jgroups.stack.GossipRouter -port 5555
#java -Dlog4j.configurationFile=log4j2.xml -cp "jgroups-3.6.9.Final.jar:log4j-api-2.6.1.jar:log4j-core-2.6.1.jar" org.jgroups.stack.GossipRouter -port 5555
