alias editdgbash='emacs ~/.dg-bash-config/*.bash'
alias editbashrc='emacs ~/.bashrc & disown'
alias sourcebashrc='source ~/.bashrc'

alias emacsd='emacs $1 & disown'
alias emacsc='emacsclient -n'

alias upgrade_motor_config_to_kinetic='sed  -Ei "s/( *)imax\: ([0-9]*)/\1imax: 0\n\1torque_limiter_gain: \2/g" motor_board_effort_controllers.yaml ; sed  -Ei "s/^( +)d\: ([0-9]*)/\1d: 0\n\1torque_limit: \2/g" motor_board_effort_controllers.yaml;'

export DG_SOFTWARE_PROJECT=DMRH

git config --global alias.ticket  '!f() { ticketnum=$1; branchName=$2; git checkout -b "F#${DG_SOFTWARE_PROJECT}-${ticketnum}_${branchName}"; }; f'


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

set_hand_e_ethercat() { echo Setting ethercat port to $1;  pushd . > /dev/null ; roscd sr_ethercat_hand_config/launch ; sed -i "s/<arg name=\"eth_port\" value=\"\w*\"/<arg name=\"eth_port\" value=\"$1\"/" *.launch ; popd > /dev/null ; }


git config --global alias.sshify '!f() { git remote set-url origin $(git remote get-url origin | sed -En "s/https:\/\/github.com\//git@github.com:/p") ; }; f'
git config --global alias.unsshify '!f() { git remote set-url origin $(git remote get-url origin | sed -En "s/git@github.com:/https:\/\/github.com\//p") ; }; f'

_eepromtool_completions()
{
    find_eth_perl_string='@list = split("\n", `ip addr`);
my @output;

for (@list)
{
    push(@output, $1) if (/\d+: ([^:]+):.*/);
}

print join(" ", @output);'

    if [ "${#COMP_WORDS[@]}" == "2" ]; then

        addr_list=$(echo $find_eth_perl_string | perl) 
        COMPREPLY=($(compgen -W "$addr_list" "${COMP_WORDS[1]}"))
    fi
}

complete -F _eepromtool_completions eepromtool
