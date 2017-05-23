source ~/.dg-bash-config/aliases.bash
source ~/.dg-bash-config/catkin_here.bash
source ~/.dg-bash-config/.bash-git-prompt/gitprompt.sh

if ! [ -e ~/.emacs ]; then
    ln -s  ~/.dg-bash-config/.emacs ~/
fi

if ! [ -e ~/.gitconfig ]; then
    ln -s  ~/.dg-bash-config/.gitconfig ~/
fi
