#!/bin/bash
source /root/Desktop/Bash_Scripts/sources/Variables.sh
# function to display menu
Show_Main_Menu() {
	echo -e "${BOLD}${BLUE}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo -e " SPECIFIC MAC ADDRESS SPOOFER"
	echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${STD}"
  echo "1. Choose Network Interface."
	echo "2. Insert Mac Address."
	echo "3. Scan For Mac Addresses."
  echo "4. Lookup Mac Addresses Of Vendors."
	echo "5. Exit"
}

Read_Options() {
	local choice
	echo -e "${BOLD}${ORANGE}Enter choice [1 - 5]${STD}"
  read choice
	case $choice in
    1) Device ;;
		2) Manual ;;
		3) Scan ;;
		4) MacLookup ;;
    5) exit 0;;
		*) echo -e "${BOLD}${LIGHTRED}Error...${STD}" && sleep 1 && clear
	esac
}

function Device() {
  clear
  sudo nmcli device
	echo -e "${BOLD}${BLUE}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo -e " Input the network device to spoof (usually eth0 or wlan0)."
	echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${STD}"
  read device
  clear
}

function Manual() {
  echo "Input Mac Address"
  read mac
  MacSpoof $device $mac
}

function MacSpoof() {
      ifconfig $1 down
      macchanger -m $2 $1
      ifconfig $1 up
      Pause
      clear
}

function Scan() {
	echo "Scanning, use CTRL + C to stop."
	airmon-ng check kill
	airmon-ng start wlan0
	airodump-ng wlan0mon
  Pause
  airmon-ng stop wlan0mon
	service network-manager start
}

function MacLookup() {
      macchanger -l | less
      Pause
      clear
}

Pause() {
  echo -e "${BOLD}${ORANGE}Press [Enter] key to continue...${STD}"
  read fackEnterKey
}

while true
do
	Show_Main_Menu
	Read_Options
done
