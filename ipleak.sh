#!/bin/bash

echo "IP"
curl -s https://ipv4.ipleak.net/json/ | grep -E 'country|city|region|continent|ip'

echo -e "\nDNS"
for i in {1..5}
do
   HASH=$(head /dev/urandom | tr -dc a-z0-9 | head -c 39 ; echo '')
   echo $(curl -s https://1$HASH.ipleak.net/dnsdetect/) &
   echo $(curl -s https://2$HASH.ipleak.net/dnsdetect/) &
   echo $(curl -s https://3$HASH.ipleak.net/dnsdetect/) &
   echo $(curl -s https://4$HASH.ipleak.net/dnsdetect/) &
   echo $(curl -s https://5$HASH.ipleak.net/dnsdetect/) &
   wait
done
