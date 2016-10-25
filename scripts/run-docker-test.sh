#!/bin/sh
docker run -d --net=red5 --name=red5-0 -e red5_port=1936 -e red5_ip=172.30.4.2 -p 1936:1935 bsolomon/red5-media:v1
docker run -d --net=red5 --name=red5-1 -e red5_port=1937 -e red5_ip=172.30.4.2 -p 1937:1935 bsolomon/red5-media:v1
docker run -d --net=red5 --name=red5-2 -e red5_port=1938 -e red5_ip=172.30.4.2 -p 1938:1935 bsolomon/red5-media:v1
sleep 30s
docker run -d --net=red5 --name=red5-manager-0 -e is_seed=true -e red5_ip=172.30.4.2 -v /var/run/docker.sock:/var/run/docker.sock -v /usr/local/docker-images/red5-manager/config:/config bsolomon/red5-manager:v1
sleep 10s
docker run -d --net=red5 --name=red5-control-0 -e red5_port=1936 -e managed_host=red5-0 -e red5_ip=172.30.4.2 -v /usr/local/docker-images/red5-control/config:/config bsolomon/red5-control:v1
docker run -d --net=red5 --name=red5-control-1 -e red5_port=1937 -e managed_host=red5-1 -e red5_ip=172.30.4.2 -v /usr/local/docker-images/red5-control/config:/config bsolomon/red5-control:v1 
docker run -it --net=red5 --name=red5-control-2 -e red5_port=1938 -e managed_host=red5-2 -e red5_ip=172.30.4.2 -v /usr/local/docker-images/red5-control/config:/config bsolomon/red5-control:v1 > /usr/local/logs/control3.txt
sleep 5m
docker logs red5-manager-0 > /usr/local/logs/manager.log
docker logs red5-control-1 > /usr/local/logs/control1.log
docker logs red5-control-2 > /usr/local/logs/control2.txt

