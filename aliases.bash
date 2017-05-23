alias editdgbash='emacs ~/.dg-bash-config/*.bash'
alias editbashrc='emacs ~/.bashrc & disown'
alias sourcebashrc='source ~/.bashrc'

alias emacsd='emacs $1 & disown'
alias emacsc='emacsclient -n'


git config --global alias.ticket  '!f() { ticketnum=$1; branchName=$2; git checkout -b "F#SRC-${ticketnum}/${branchName}"; }; f'


alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../../"
alias .....="cd ../../../../"
alias cpr='cp -r'

alias psros='ps aux | grep ros'
alias rossrc='roscd ; cd ../src'

alias l='ls -l -a -h'

alias docker_new_with_networking='f() { docker run -it --privileged $1 --hostname=hestia_docker --network=host -e DISPLAY -e QT_X11_NO_MITSHM=1 -e LOCAL_USER_ID=$(id -u) --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" shadowrobot/dexterous-hand:kinetic ; }; f '

alias docker_new_no_networking='f() { docker run -it --host_name=hestia_docker $1 -e DISPLAY -e QT_X11_NO_MITSHM=1 -e LOCAL_USER_ID=$(id -u) --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" shadowrobot/dexterous-hand:kinetic ; }; f'
