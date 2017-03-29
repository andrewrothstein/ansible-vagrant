[![CircleCI](https://circleci.com/gh/andrewrothstein/ansible-vagrant.svg?style=svg)](https://circleci.com/gh/andrewrothstein/ansible-vagrant)
andrewrothstein.vagrant
=========

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
