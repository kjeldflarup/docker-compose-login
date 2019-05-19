Docker Compose Login
====================

This setup is intended as a docker replacement for using chroot in /etc/passwd

A possible usage is a sftp/scp server, where the host has port 22 open for other purposes too.

Configuration of the container to run etc is done using `docker-compose.yml`
Please see `docker-compose.yml.sample`

Important, there must be a service called `user` or the actual username.

.. code :: bash
  sudo install.sh

This creates the user `docker-compose-login`, which cannot do a login, but is used as a middle stage, to be able to run docker.

Logins
------

The logins using the docker-compose-login are created like this:
.. code :: bash
  sudo adduser --gecos "" --ingroup docker-login --shell /srv/docker/docker-compose-login/docker-compose-login sslforfree

This creates a user with a home. Please feel fre to use `--home` and `--no-create-home` options, just be aware that the home must be writable to lock .Xauthority. 

The generated home may be mapped into the container, but this may require an entry in `docker-compose.yml` per login.


