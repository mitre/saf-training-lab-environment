cd /workspaces/saf-training-lab-environment

docker exec nginx apt-get update

docker exec nginx apt-get install -y python3.9

docker exec nginx ls /usr/bin | grep python3.9

git clone -b docker https://github.com/mitre/ansible-nginx-stigready-hardening.git

cd ansible-nginx-stigready-hardening