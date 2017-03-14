#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

if [[ $# -eq 0 ]] ; then
    echo "ERROR - Missing Argument"
    echo -e "\t-- You must enter the name of the new role to scaffold"
    echo "Usage:"
    echo -e "\t$0 ROLENAME"
    exit 0
fi

echo "Initializing role $1"
printf "~~ Creating diretory structure"
mkdir $1 $1/defaults $1/files $1/handlers $1/meta $1/tasks $1/templates $1/tests $1/vars
printf " [\e[1;32mDone\e[0m]\n"
printf "~~ Creating placeholder files"

cat <<EOF > $1/defaults/main.yml
---
# defaults file for template

EOF

cat <<EOF > $1/handlers/main.yml
---
# handlers file for template

EOF

cat <<EOF > $1/tasks/main.yml
---
# tasks file for template

EOF

cat <<EOF > $1/vars/main.yml
---
# vars file for template

EOF

cat <<EOF > $1/tests/test.yml
---
- hosts: localhost
  remote_user: root
  roles:
  - "$1"

EOF

cat <<EOF > $1/tests/inventory
localhost

EOF

cat <<EOF > $1/meta/main.yml
galaxy_info:
  author: "Robert Fairhead"
  description: "Empty role starter"

  license:
  - MIT

  min_ansible_version: 2

  github_branch: master

  platforms:
  - name: Ubuntu
    versions:
    - xenial

  galaxy_tags:
  - development

dependencies: []

EOF
printf " [\e[1;32mDone\e[0m]\n"
printf "~~ Creating LICENSE file"
cat <<EOF > $1/LICENSE
MIT License

Copyright (c) 2017 Robert Fairhead

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

EOF
printf " [\e[1;32mDone\e[0m]\n"
printf "~~ Creating README.md file"
cat <<EOF > $1/README.md
Ansible Role: $1
======================


Requirements
------------

- Python 3+
- Ansible 2.x

Installation
------------

Installing roles from Ansible Galaxy:

    $ ansible-galaxy install username.template

Dependencies
------------

Install all dependencies needed for this role.

    $ ansible-galaxy install -r requirements.yml

Required dependencies:
- none

Role Variables
--------------

|parameter  |required   |default    |choices    |comments               |
|---        |---	    |---	    |---	    |---                    |
|rolename   |yes        |   	    |   	    |ansible-role-template  |

Example Playbook
----------------

    - hosts: localhost
      remote_user: root
      roles:
      - "$1"

Testing
-------

Testing on your local machine

    $ ansible-playbook roles/template/tests/test.yml --extra-vars "rolename=roles/template" --syntax-check

Testing with Travis CI

    $ ansible-playbook tests/test.yml -i tests/inventory --extra-vars "rolename=ansible-role-template" --syntax-check

License
-------

MIT

Author Information
------------------

- Author: Robert Fairhead

EOF

printf " [\e[1;32mDone\e[0m]\n"