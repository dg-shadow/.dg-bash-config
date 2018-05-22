docker_name=$1
echo "export DOCKER_NAME=':$docker_name'" >> ~/.docker_name.bash
echo "source ~/.dg-bash-config/source.bash" >> ~/.bashrc

mkdir -p ~/.config/terminator
cp ~/.dg-bash-config/terminator_config ~/.config/terminator/config

source ~/.dg-bash-config/source.bash

