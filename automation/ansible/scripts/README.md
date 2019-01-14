## Sumo Logic Installation Instructions

### Pre-requisites:
* Install Ansible
* Configure Ansible to use `~/.ssh/config` file for all your hosts that go through bastion. Reference to do this <a href="https://blog.scottlowe.org/2015/12/24/running-ansible-through-ssh-bastion-host/">here<a/>.
* Ensure your ansible host file: `/etc/ansible/hosts` has the same host names you configured above in ~/.ssh/config

<i>via terminal / ansible from this directory:</i>

<pre>
# Install on host
# NOTE that host-name is the host name in my ~/.ssh/config - update accordingly if your host names are different.

cd /Your/Repos/ansible/
ansible-playbook -i host-name, -e ansible_network_os=vyos sumo-install.yml
</pre>

* The **sumo-install.sh** script removes the bash variable file **sumo-vars.sh** from the EC2 Host so that your Sumo Access ID and Key are not sitting in plain text on the instance.
* Storing your Sumo Access ID and Key in git is not recommended. Better to explore ansible combined with Vault. Not in this example's scope.
