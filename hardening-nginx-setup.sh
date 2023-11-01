cd /workspaces/saf-training-lab-environment

docker exec nginx apt-get update

docker exec nginx apt-get install -y python3

docker exec nginx ls /usr/bin | grep python3

git clone -b docker https://github.com/mitre/ansible-nginx-stigready-hardening.git || true

chmod 755 ansible-nginx-stigready-hardening

python3 -m pip install --user ansible

cd ./ansible-nginx-stigready-hardening
