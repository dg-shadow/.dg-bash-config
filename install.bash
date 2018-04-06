docker_name=$1
echo "export DOCKER_NAME=':$docker_name'" >> ~/.docker_name.bash

echo "source ~/.dg-bash-config/source.bash" >> ~/.bashrc
source ~/.dg-bash-config/source.bash

