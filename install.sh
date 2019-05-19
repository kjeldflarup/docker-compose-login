#!/bin/sh

cd `dirname $0`

if [ ! -d /etc/sudoers.d ] ; then
  echo Missing /etc/sudoers.d, cannot be used on this installation
  exit 1
fi

# first create docker-compose-login user
if [ "`grep docker-compose-login /etc/passwd`" = "" ] ; then
  sudo adduser --shell /bin/false --gecos "" --disabled-login --no-create-home docker-compose-login
fi

# Allow docker-compose-login to run docker, Assume docker group is created by docker
sudo usermod -aG docker docker-compose-login

# Allow any user to execute docker-compose-login
if [ ! -f /etc/sudoers.d/docker-compose-login ] ; then
  echo "%docker-compose-login ALL=(docker-compose-login) NOPASSWD: $PWD/docker-compose-login-sudo" | sudo tee -a /etc/sudoers.d/docker-compose-login
fi

# protect the privilege escalation scripts
sudo chmod 755 docker-compose* .
sudo chown docker-compose-login:docker-compose-login docker-compose* .
sudo chmod 440 /etc/sudoers.d/docker-compose-login
