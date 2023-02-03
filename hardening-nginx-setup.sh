cd /workspaces/saf-training-lab-environment

docker exec nginx apt-get update

docker exec nginx apt-get install -y python3.9

docker exec nginx ls /usr/bin | grep python3.9

git clone -b docker https://github.com/mitre/ansible-nginx-stigready-hardening.git || true

python3 -m pip install --user ansible

cd /workspaces/saf-training-lab-environment/ansible-nginx-stigready-hardening
