#!/bin/bash

docker rm -f `docker ps -qa` #*************BEWARE**************would remove all running containers.

docker rmi $(docker images -q)  #*************BEWARE**************would remove all untagged images.

export HOST_IP=<HOST_IP>

docker-compose up -d --remove-orphans

sleep 20

#Below command will add properties in form of Consul Key-Value Pair. Add as shown below if required
curl --request PUT --data '<DB_IP>' http://<HOST_IP>:<PORT>/v1/kv/DB_IP		
curl --request PUT --data '<DB_PORT>' http://<HOST_IP>:<PORT>/v1/kv/DB_PORT
curl --request PUT --data '<ENABLE_APM>' http://<HOST_IP>:<PORT>/v1/kv/ENABLE_APM
curl --request PUT --data '<APM_SERVER_URL>' http://<HOST_IP>:<PORT>/v1/kv/APM_SERVER_URL

#Restart all docker containers which depends on the above Consul Key-Values
docker restart <service_name>  #give service name of services that would run.