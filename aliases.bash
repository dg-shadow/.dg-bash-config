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
alias rossrc='roscd ; cd src'

alias l='ls -l -a -h'

alias roscd='f() { if [ $# == 0 ] ; then  roscd ; cd .. ; else roscd $1 ; fi ; }; f'


# alias lint_cpp="f() { local array_h ; if [ $# == 0 ] ; then FILE=. ; else FILE=$1 ; fi ; echo $FILE ; IFS=' ' read -r -a array_h <<< $(find . -name *.h) ; for element in ${array_h[@]} ; do  echo $element; done ; } ; f"

_list_docker_images()
{
    perl_rocks='
@list = split("\n", `docker images`);
shift @list;
@output = ();
for (@list)
{
  ($repo, $tag, @rest) = split /\s+/;
  push (@output, "$repo:$tag") unless $repo eq "<none>" or $tag eq "<none>";
}
print join(" ", @output);
'
    echo $perl_rocks | perl
}

_docker_image_completion()
{
      if [ "${#COMP_WORDS[@]}" == "2" ]; then

        image_list=$(_list_docker_images) 
        COMPREPLY=($(compgen -W "$image_list" "${COMP_WORDS[1]}"))
    fi  
}

new_nvidia_docker() {
    name_string=""
    if [ ! -z "$2" ] ; then
       name_string="--name $2"
    fi
    docker run $name_string -it --security-opt seccomp=unconfined --network=host --pid=host --privileged --runtime nvidia -e NVIDIA_DRIVER_CAPABILITIES=all -e NVIDIA_VISIBLE_DEVICES=all -e DISPLAY -e QT_X11_NO_MITSHM=1 -e LOCAL_USER_ID=$(id -u) -e ROS_MASTER_URI=http://localhost:11311 -v /tmp/.X11-unix:/tmp/.X11-unix:rw -v /dev/input:/dev/input:rw -v /run/udev/data:/run/udev/data:rw $1 bash -c "echo /usr/local/lib/x86_64-linux-gnu | sudo tee /etc/ld.so.conf.d/glvnd.conf && sudo ldconfig && terminator"; }

new_docker() {
    name_string=""
    if [ ! -z "$2" ] ; then
       name_string="--name $2"
    fi
    docker run $name_string -it --security-opt seccomp=unconfined --network=host --pid=host --privileged --ulimit core=-1 -e DISPLAY -e QT_X11_NO_MITSHM=1 -e LOCAL_USER_ID=$(id -u) -e interface=enx5647929203 -e ROS_MASTER_URI=http://localhost:11311 -v /tmp/.X11-unix:/tmp/.X11-unix:rw -v /dev/input:/dev/input:rw -v /run/udev/data:/run/udev/data:rw $1 bash -c "terminator -T 'Teleop Server Container' -x bash -c '/usr/local/bin/teleop-server-setup.sh && bash'"
}
complete -F _docker_image_completion new_nvidia_docker
complete -F _docker_image_completion new_docker

set_hand_h_ethercat() { echo Setting ethercat port to $1;  pushd . > /dev/null ; roscd fh_config/hardware ; sed -i "s/ethercat_port: \w*/ethercat_port: $1/" *.yaml ; popd > /dev/null ; }
set_hand_r_ethercat() { echo Setting ethercat port to $1;  pushd . > /dev/null ; roscd rh_robot/config ; sed -i "s/ethercat_port: \w*/ethercat_port: $1/" *.yaml ; popd > /dev/null ; }

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

alias strip_log='sed -e "s/\([0-9.]*\) \([A-Z]*\).*]/\1 \2/"'

strip_log2 ()
{
    perl -e'
         use warnings;
         use strict;

         use Term::ANSIColor qw(:constants);
         my @lines = <>; 
         for (@lines)
         {
           if (/([\d\.]+) (\w+) [^\]]+] (.*)/)
           {
             my $output = "$1 - $2 - $3\n" ;
             
             if ($2 eq "WARN") {
                print YELLOW, $output, RESET; 
             } elsif ($2 eq "DEBUG") 
             { 
               print GREEN, $output, RESET;
             } elsif ($2 eq "FATAL" || $2 eq "ERROR") 
             {
               print RED, $output, RESET;
             }
             else {
               print $output; 
             }
          }
          else { print ; }
       }
    '  
}

nice_strip ()
{
    perl -e' 
         use warnings;
         use strict;

         use Term::ANSIColor qw(:constants);
         my @lines = <>; 
         for (@lines)
         {
           unless (/([\d\.]+) (\w+) [^\]]+] (.*)/)
           {
              print;  next;
           }
           chomp(my $date = `date -d\@$1`);
           my $output = "$date - $2 - $1\n-\n$3\n--------\n\n";


           if ($2 eq "WARN") {
              print YELLOW, $output, RESET; 
           } elsif ($2 eq "DEBUG") 
           { 
             print GREEN, $output, RESET;
           } elsif ($2 eq "FATAL" || $2 eq "ERROR") 
           {
             print RED, $output, RESET;
           }
           else {
             print $output; 
           }

         }
   '
    
}

_container_names()
{
    if [ "${#COMP_WORDS[@]}" == "2" ]; then
        COMPREPLY=($(compgen -W $(docker ps --format "{{.Names}}")))
    fi
}

check_pylintrc() { if ! [ -f /tmp/pylintrc ]; then wget -O /tmp/pylintrc https://raw.githubusercontent.com/shadow-robot/sr-build-tools/fd2350484fec1004838e41c3f643aad888be0170/ansible/roles/ci/code_style_check/python/files/pylintrc; fi; }
check_apt_package() { if [[ $(dpkg -l | grep -w $1 | wc -l) -eq 0 ]]; then sudo apt install -y $1; fi; }
sr_pylint_here() { check_pylintrc; check_apt_package "pylint";  pylint --rcfile /tmp/pylintrc --max-line-length 120 *; }
sr_pylint_sorted_here() { sr_pylint_here | sort -V | grep -v "\*\*\*\*\*\*\*\*"; }

add_key()
{
    docker cp ~/.ssh/id_rsa $1:/home/user/.ssh
    docker cp ~/.ssh/id_rsa.pub $1:/home/user/.ssh
 
    docker exec $1 sh -c 'echo hello >>  /home/user/.ssh/authorized_keys'

    docker exec $1 echo eval "$(ssh-agent -s)"
    docker exec $1 sleep 1
    docker exec $1 ssh-add
}

complete -F _container_names add_key
alias docker_login="aws ecr get-login-password --region eu-west-2 | docker login --username AWS --password-stdin 080653068785.dkr.ecr.eu-west-2.amazonaws.com"

create_nvidia() { docker create --name $1 -it --security-opt seccomp=unconfined --network=host --ipc=host --pid=host --privileged --gpus all -e NVIDIA_DRIVER_CAPABILITIES=all -e NVIDIA_VISIBLE_DEVICES=all -e DISPLAY -e QT_X11_NO_MITSHM=1 -e LOCAL_USER_ID=$(id -u) -e XDG_RUNTIME_DIR=/run/user/$(id -u) -e ROS_MASTER_URI=http://localhost:11311 -v /tmp/.X11-unix:/tmp/.X11-unix:rw -v /dev/input:/dev/input:rw -v /dev:/dev -v /run/udev/data:/run/udev/data:rw $2 terminator ; }
