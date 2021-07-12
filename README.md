andrewrothstein.vagrant
=========
![Build Status](https://github.com/andrewrothstein/ansible-vagrant/actions/workflows/build.yml/badge.svg)

Installs [vagrant](https://www.vagrantup.com/)

Requirements
------------

See [meta/main.yml](meta/main.yml)

Role Variables
--------------

See [defaults/main.yml](defaults/main.yml)

Dependencies
------------

See [meta/main.yml](meta/main.yml)

Example Playbook
----------------

```yml
-  hosts: servers
   roles:
     - andrewrothstein.vagrant
 ```

License
-------

MIT

Author Information
------------------

Andrew Rothstein <andrew.rothstein@gmail.com>
