User data to install docker and Docker compose
check at boot by running:
```
docker info
docker-compose version
```
data:
```
User Data for Docker Install
#!/bin/bash
yum update -y
amazon-linux-extras install docker
service docker start
systemctl enable docker
usermod -a -G docker ec2-user
# Install docker compose
curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
wget https://raw.githubusercontent.com/abombaywala/workspace/main/tools/aws_route_53_auto_update/update_r53.sh -O /var/lib/cloud/scripts/per-boot/update_r53.sh
chmod +x /var/lib/cloud/scripts/per-boot/update_r53.sh
sh /var/lib/cloud/scripts/per-boot/update_r53.sh
cd /home/ec2-user/
wget https://raw.githubusercontent.com/abombaywala/workspace/main/docker-compose/ghost/ghost-docker-compose.yml
docker-compose -f ghost-docker-compose.yml up -d
```