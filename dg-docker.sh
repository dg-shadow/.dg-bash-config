
#!/usr/bin/env bash

set -e # fail on errors

docker_image=$1

mkdir -p /tmp/docker_tmp
cd /tmp/docker_tmp
touch Dockerfile

echo "FROM $docker_image" > Dockerfile
echo "RUN apt-get update && apt-get install -y emacs gnome-icon-theme && cd /home/user/ && git clone https://github.com/dg-shadow/.dg-bash-config && chown user:user .dg-bash-config" >> Dockerfile




docker build --tag "$docker_image-dg" .

cd
rm -rf /tmp/docker_tmp
