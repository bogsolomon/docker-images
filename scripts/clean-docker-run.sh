#!/bin/sh
docker stop red5-manager-0
docker stop red5-control-0
docker stop red5-control-1
docker stop red5-control-2
docker stop red5-control-3
docker stop red5-0
docker stop red5-1
docker stop red5-2
docker stop red5-3
docker rm red5-manager-0
docker rm red5-control-0
docker rm red5-control-1
docker rm red5-control-2
docker rm red5-control-3
docker rm red5-0
docker rm red5-1
docker rm red5-2
docker rm red5-3
