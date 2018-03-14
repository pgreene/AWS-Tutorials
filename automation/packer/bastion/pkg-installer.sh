#/bin/bash
sleep 50

# Add another user 
sudo adduser --disabled-password --gecos "" another
sudo mkdir /home/another/.ssh/
sudo cp /home/ubuntu/authorized_keys /home/another/.ssh/authorized_keys
sudo chmod 0600 /home/another/.ssh/authorized_keys
sudo chown -R another:another /home/another/.ssh/
sudo cat /home/another/.ssh/authorized_keys

# Add pkgs
sudo apt update -y

sudo apt install -y apt-listchanges
sudo apt install -y build-essential
sudo apt install -y clamav-daemon
sudo apt install -y collectd
sudo apt install -y debsecan
sudo apt install -y debsums
sudo apt install -y dstat
sudo apt install -y fail2ban
sudo apt install -y htop
sudo apt install -y nginx
sudo apt install -y nmap
sudo apt install -y libpam-tmpdir
sudo apt install -y lsof
sudo apt install -y lynis
sudo apt install -y mysql-client
sudo apt install -y mysql-utilities
sudo apt install -y net-tools
sudo apt install -y policycoreutils
sudo apt install -y python-apt
sudo apt install -y python-pip
sudo apt install -y redis-tools
sudo apt install -y stunnel
sudo apt install -y telnet-ssl
sudo apt install -y ufw
sudo apt install -y wget
sudo apt install -y zip

# Enable nginx
sudo systemctl enable nginx.service
sudo systemctl start nginx.service
sudo lsof -i :80

# upgrade pkgs
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade

# Setup logentries
# sudo -i
# echo 'deb http://rep.logentries.com/ xenial main' > /etc/apt/sources.list.d/logentries.list
# gpg --keyserver pgp.mit.edu --recv-keys A5270289C43C79AD && gpg -a --export A5270289C43C79AD | apt-key add -
# apt update -y
# apt install -y python-setproctitle logentries
# le register
# apt-get install logentries-daemon

# wget https://raw.github.com/logentries/le/master/install/linux/logentries_install.sh 
# bash logentries_install.sh 8d9338b6-b8eb-484e-add9-12d633b98b10

# Configure NTP and Rsyslog
sudo mv /etc/ntp.conf /etc/ntp.conf.bkp
sudo cp /home/ubuntu/ntp.conf /etc/ntp.conf
sudo chown root:root /etc/ntp.conf
sudo chmod 0644 /etc/ntp.conf
sudo systemctl is-enabled ntp
sudo systemctl enable ntp
sudo service ntp restart
sudo timedatectl
sudo mv /etc/rsyslog.conf /etc/rsyslog.conf.bkp
sudo cp /home/ubuntu/rsyslog.conf /etc/rsyslog.conf
sudo chown root:root /etc/rsyslog.conf
sudo chmod 0644 /etc/rsyslog.conf
sudo service rsyslog restart

# RDS Scripts
sudo cp /home/ubuntu/rds_* /usr/local/bin/
sudo chown root:root /usr/local/bin/rds_*
sudo chmod 0755 /usr/local/bin/rds_*

# Run local audit
sudo lynis -Q audit system
