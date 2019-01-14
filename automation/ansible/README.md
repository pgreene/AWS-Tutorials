## Purpose

This example can be used to install a sumo collector on an EC2 Host. Adding sources, within your Sumo Logic Account would be the next step.

## Upload Sumo Collector and Install it:

```bash
# -i represents host names in your /etc/ansible/hosts which are referenced in your SSH config ~/.ssh/config
ansible-playbook -i host-name, -e ansible_network_os=vyos sumo-install.yml
```

## Remove Installed Sumo Collector:

```bash
# -i represents host names in your /etc/ansible/hosts which are referenced in your SSH config ~/.ssh/config
ansible-playbook -i host-name, -e ansible_network_os=vyos sumo-remove.yml
```

## Pre-requisites
* You have a Sumo Logic Account
* Ansible is installed
* SSH Config is configured to tunnel through bastion host
* Ansible is configured to use SSH Config
* Ansible Hosts file has Host Names configured in SSH Config

Reference: https://blog.scottlowe.org/2015/12/24/running-ansible-through-ssh-bastion-host/
