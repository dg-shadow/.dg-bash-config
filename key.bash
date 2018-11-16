mkdir ~/.ssh/
scp dg@hestia:~/.ssh/id_rsa ~/.ssh/
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
