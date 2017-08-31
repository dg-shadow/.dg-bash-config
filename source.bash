if ! [ -e ~/.emacs ]; then
    ln -s  ~/.dg-bash-config/.emacs ~/
fi

if ! [ -e ~/.gitconfig ]; then
    ln -s  ~/.dg-bash-config/.gitconfig ~/
fi

if [ -e ~/.docker_name.bash ]; then
    source ~/.docker_name.bash
fi

source ~/.dg-bash-config/aliases.bash
source ~/.dg-bash-config/catkin_here.bash
source ~/.dg-bash-config/.bash-git-prompt/gitprompt.sh

