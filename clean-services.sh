
#!/bin/sh
while true;
do
allserviceID="$(curl http://<HOST_IP>:<PORT>/v1/agent/services | jq 'keys')"
serviceID="$(curl http://<HOST_IP>:<PORT>/v1/agent/services | jq -r 'keys[0]')"
for service in "${serviceID[@]}"
do
echo "$service"
size=${#allserviceID}
if [ $size -ge 7 ]; then
if [ "$serviceID" != "consul" ]; then
curl --request PUT http://<HOST_IP>:<PORT>/v1/agent/service/deregister/$serviceID
fi
else
break
fi
done
done

