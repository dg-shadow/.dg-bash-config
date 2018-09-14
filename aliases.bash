alias editdgbash='emacs ~/.dg-bash-config/*.bash'
alias editbashrc='emacs ~/.bashrc & disown'
alias sourcebashrc='source ~/.bashrc'

alias emacsd='emacs $1 & disown'
alias emacsc='emacsclient -n'


git config --global alias.ticket  '!f() { ticketnum=$1; branchName=$2; git checkout -b "F#SRC-${ticketnum}_${branchName}"; }; f'


alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../../"
alias .....="cd ../../../../"
alias cpr='cp -r'

alias psros='ps aux | grep ros'
alias rossrc='roscd ; cd ../src'

alias l='ls -l -a -h'

alias docker_new_with_networking='f() { docker run -it --privileged $1 --network=host -e DISPLAY -e QT_X11_NO_MITSHM=1 -e LOCAL_USER_ID=$(id -u) --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" shadowrobot/dexterous-hand:kinetic ; }; f '

alias docker_new_no_networking='f() { docker run -it $1 -e DISPLAY -e QT_X11_NO_MITSHM=1 -e LOCAL_USER_ID=$(id -u) --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" shadowrobot/dexterous-hand:kinetic ; }; f'

set_hand_h_ethercat() { echo Setting ethercat port to $1;  pushd . > /dev/null ; roscd fh_config/hardware ; sed -i "s/ethercat_port: \w*/ethercat_port: $1/" *.yaml ; popd > /dev/null ; }

git config --global alias.sshify '!f() { git remote set-url origin $(git remote get-url origin | sed -En "s/https:\/\/github.com\//git@github.com:/p") ; }; f'
