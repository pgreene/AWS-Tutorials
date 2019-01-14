#!/bin/bash
source /home/ec2-user/sumo-vars.sh
# --------------------------------------------- #
# --- Script: sumo-install.sh ----------------- #
# --- Author: DevOps / Paul Greene ------------ #
# --- Purpose: Install Sumo Collector Agent --- #
# --------------------------------------------- #

# ------------------ #
# --- References --- #
# ------------------ #

# https://help.sumologic.com/03Send-Data/Installed-Collectors/05Reference-Information-for-Collector-Installation/02Download-a-Collector-from-a-Static-URL
# https://help.sumologic.com/03Send-Data/Installed-Collectors/04Install-a-Collector-on-Linux#Install_using_the_command_line_installer

# ---------------------- #
# --- Pre-requisites --- #
# ---------------------- #
sudo yum -y install wget

#-------------------------------- #
# --- Get Sumo Installer File --- #
# --- Install via cli ----------- #
# --- Can be used with Ansible -- #
# ------------------------------- #
cd /usr/local/bin/
sudo wget "https://collectors.sumologic.com/rest/download/linux/64" -O SumoCollector.sh && sudo chmod +x SumoCollector.sh
sudo ./SumoCollector.sh -q -Vsumo.accessid=$SUMOACCESSID -Vsumo.accesskey=$SUMOACCESSKEY -Vcollector.name=$COLLECTORNAME -Vcategory=$CATEGORY

sudo service collector start

# --- Remove variables file so Sumo Access ID and Password are not stored on Instance
# --- uploaded by ansible: ../ansible/sumo-install.yml
# --- See Sumo Documentation in Reference for installing a collector / creating sumo access key;
# --- https://help.sumologic.com/01Start-Here/Quick-Start-Tutorials/Set-Up-Sumo-Logic-Tutorial/Part-1%3A-Install-a-Collector
sudo rm /home/ec2-user/sumo-vars.sh