#!/bin/bash
#v1
# A bash script to update a Cloudflare DNS A record with the external IP of the source machine
# Used to provide DDNS service for my home
# Needs the DNS record pre-creating on Cloudflare

# Proxy - uncomment and provide details if using a proxy
#export https_proxy=http://<proxyuser>:<proxypassword>@<proxyip>:<proxyport>

# v2
# From https://gist.github.com/Tras2/cba88201b17d765ec065ccbedfb16d9a
# If DNS record is not created on cloutflare it will, else just update
# You will need to install jq
#     centOS - sudo yum install jq
#     ubuntu - sudo apt install jq
# Run $sh cloudflare-ddns-update.sh
# it will give success result if Ok

# Cloudflare zone is the zone which holds the record
zone=${DNS_ZONE}
# dnsrecord is the A record which will be updated
dnsrecord=${DNS_RECORD}

## Cloudflare authentication details
## keep these private
cloudflare_auth_email=${AUTH_EMAIL_CLOUDFLARE}
cloudflare_auth_key=${AUTH_API_KEY_CLOUDFLARE}

# Get the current external IP address
ip=$(curl -s -X GET https://checkip.amazonaws.com)

echo "Current IP is $ip"

if host $dnsrecord 8.8.8.8 | grep "has address" | grep "$ip"; then
  echo "$dnsrecord is currently set to $ip; no changes needed"
  exit
fi

# if here, the dns record needs updating

# get the zone id for the requested zone
zoneid=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones?name=$zone&status=active" \
  -H "X-Auth-Email: $cloudflare_auth_email" \
  -H "X-Auth-Key: $cloudflare_auth_key" \
  -H "Content-Type: application/json" | jq -r '{"result"}[] | .[0] | .id')

echo "Zoneid for $zone is $zoneid"

# get the dns record id
dnsrecord_id=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones/$zoneid/dns_records?type=A&name=$dnsrecord" \
  -H "X-Auth-Email: $cloudflare_auth_email" \
  -H "X-Auth-Key: $cloudflare_auth_key" \
  -H "Content-Type: application/json" | jq -r '{"result"}[] | .[0] | .id')

echo "dnsrecord_id for $dnsrecord is $dnsrecord_id"

if [ "$dnsrecord_id" == "null" ];
then
# create new record
curl -X POST "https://api.cloudflare.com/client/v4/zones/$zoneid/dns_records" \
     -H "X-Auth-Email: $cloudflare_auth_email" \
     -H "X-Auth-Key: $cloudflare_auth_key" \
     -H "Content-Type: application/json" \
     --data "{\"type\":\"A\",\"name\":\"$dnsrecord\",\"content\":\"$ip\",\"ttl\":1,\"priority\":10,\"proxied\":false}" | jq
else
# update the record
curl -s -X PUT "https://api.cloudflare.com/client/v4/zones/$zoneid/dns_records/$dnsrecord_id" \
  -H "X-Auth-Email: $cloudflare_auth_email" \
  -H "X-Auth-Key: $cloudflare_auth_key" \
  -H "Content-Type: application/json" \
  --data "{\"type\":\"A\",\"name\":\"$dnsrecord\",\"content\":\"$ip\",\"ttl\":1,\"proxied\":false}" | jq
fi