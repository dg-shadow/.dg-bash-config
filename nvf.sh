
#!/usr/bin/env bash

set -e # fail on errors
#set -x # echo commands run

docker_image=$1

mkdir -p /tmp/docker_nvidia_tmp
cd /tmp/docker_nvidia_tmp
touch Dockerfile

echo "FROM $docker_image" > Dockerfile
echo "LABEL com.nvidia.volumes.needed=\"nvidia_driver\"" >> Dockerfile
echo "ENV PATH /usr/local/nvidia/bin:\${PATH}" >> Dockerfile
echo "ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64:\${LD_LIBRARY_PATH}" >> Dockerfile
echo "RUN apt update && apt -fy install bash-completion emacs gnome-icon-theme && cd /home/user && git clone https://github.com/dg-shadow/.dg-bash-config && chown -R user:user .dg-bash-config " >> Dockerfile



docker build --tag "$docker_image-nvidia" .

cd
rm -rf /tmp/docker_nvidia_tmp
