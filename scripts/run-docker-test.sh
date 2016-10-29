#!/bin/bash
numServers=$1
time=$2
start_port=1936
echo "Running test for" $numServers "servers for" $time "minutes"
totalNumServers=$(( $numServers - 1 ))
for((i=0;i<=totalNumServers;i++))
do
	port=$(($start_port + $i))
	docker -H 172.30.4.2:4000 run -d --net=red5 --name=red5-$i -e red5_port=$port -v /etc/hostname:/hostname -p $port:1935 bsolomon/red5-media:v1
done
sleep 30s
docker -H 172.30.4.2:4000 run -d --net=red5 --name=red5-manager-0 -e is_seed=true -v /var/run/docker.sock:/var/run/docker.sock -v /usr/local/docker-images/red5-manager/config:/config bsolomon/red5-manager:v1
nohup docker -H 172.30.4.2:4000 logs -f red5-manager-0 > /usr/local/logs/manager.log &
sleep 10s
for((j=0;j<=totalNumServers;j++))
do
	port=$(($start_port + $j))
	docker -H 172.30.4.2:4000 run -d --net=red5 --name=red5-control-$j -e red5_port=$port -e managed_host=red5-$j -v /var/run/docker.sock:/var/run/docker.sock -v /usr/local/docker-images/red5-control/config:/config bsolomon/red5-control:v1
	nohup docker -H 172.30.4.2:4000 logs -f red5-control-$j > /usr/local/logs/control$j.log &
done
sleep ${time}m
./clean-docker-run.sh

#docker -H 172.30.4.2:4000 run -d --net=red5 --name=red5-0 -e red5_port=1936 -e red5_ip=172.30.4.2 -p 1936:1935 bsolomon/red5-media:v1
#docker -H 172.30.4.2:4000 run -d --net=red5 --name=red5-1 -e red5_port=1937 -e red5_ip=172.30.4.2 -p 1937:1935 bsolomon/red5-media:v1
#docker -H 172.30.4.2:4000 run -d --net=red5 --name=red5-2 -e red5_port=1938 -e red5_ip=172.30.4.2 -p 1938:1935 bsolomon/red5-media:v1
#docker -H 172.30.4.2:4000 run -d --net=red5 --name=red5-3 -e red5_port=1939 -e red5_ip=172.30.4.2 -p 1939:1935 bsolomon/red5-media:v1
#sleep 30s
#docker -H 172.30.4.2:4000 run -d --net=red5 --name=red5-manager-0 -e is_seed=true -e red5_ip=172.30.4.2 -v /var/run/docker.sock:/var/run/docker.sock -v /usr/local/docker-images/red5-manager/config:/config bsolomon/red5-manager:v1
#nohup docker -H 172.30.4.2:4000 logs -f red5-manager-0 > /usr/local/logs/manager.log &
#sleep 10s
#docker -H 172.30.4.2:4000 run -d --net=red5 --name=red5-control-0 -e red5_port=1936 -e managed_host=red5-0 -e red5_ip=172.30.4.2 -v /usr/local/docker-images/red5-control/config:/config bsolomon/red5-control:v1
#nohup docker -H 172.30.4.2:4000 logs -f red5-control-0 > /usr/local/logs/control0.log &
#docker -H 172.30.4.2:4000 run -d --net=red5 --name=red5-control-1 -e red5_port=1937 -e managed_host=red5-1 -e red5_ip=172.30.4.2 -v /usr/local/docker-images/red5-control/config:/config bsolomon/red5-control:v1
#nohup docker -H 172.30.4.2:4000 logs -f red5-control-1 > /usr/local/logs/control1.log &
#docker -H 172.30.4.2:4000 run -d --net=red5 --name=red5-control-2 -e red5_port=1938 -e managed_host=red5-2 -e red5_ip=172.30.4.2 -v /usr/local/docker-images/red5-control/config:/config bsolomon/red5-control:v1
#nohup docker -H 172.30.4.2:4000 logs -f red5-control-2 > /usr/local/logs/control2.log &
#docker run -H 172.30.4.2:4000 -d --net=red5 --name=red5-control-3 -e red5_port=1939 -e managed_host=red5-3 -e red5_ip=172.30.4.2 -v /usr/local/docker-images/red5-control/config:/config bsolomon/red5-control:v1
#nohup docker -H 172.30.4.2:4000 logs -f red5-control-3 > /usr/local/logs/control3.log &
#sleep 15m
#./clean-docker-run.sh

