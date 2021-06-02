#!/bin/bash
source /root/Desktop/Bash_Scripts/sources/Variables.sh
# function to display menu
Interface() {
	clear
  sudo nmcli device
	echo -e "${BOLD}${BLUE}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo -e "input the network device to spoof (usually eth0 or wlan0)."
	echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${STD}"
  read device
	MacSpoof $device
}

function MacSpoof() {
			echo -e "${BOLD}${BLUE}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${STD}"
      ifconfig $1 down
      macchanger -r $1
      ifconfig $1 up
			echo -e "${BOLD}${BLUE}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${STD}"
			Pause
}

Pause() {
  echo -e "${BOLD}${ORANGE}Press [Enter] key to continue...${STD}"
  read fackEnterKey
}

Interface
