#!/bin/bash
source /root/Desktop/Bash_Scripts/sources/Variables.sh

Pause() {
  echo -e "${BOLD}${ORANGE}Press [Enter] key to continue...${STD}"
  read fackEnterKey
}

Random() {
  bash /root/Desktop/Bash_Scripts/Network/Mac_Spoofer/Random_Mac.sh
}

Specific() {
  bash /root/Desktop/Bash_Scripts/Network/Mac_Spoofer/Specific_Mac.sh
}

Current() {
  clear
  sudo nmcli device
	echo -e "${BOLD}${BLUE}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo -e " Input the network device to use (usually eth0 or wlan0)."
	echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${STD}"
  read device
	macchanger -s $device
  Pause
}
Original() {
  clear
  sudo nmcli device
	echo -e "${BOLD}${BLUE}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo -e " Input the network device to use (usually eth0 or wlan0)."
	echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${STD}"
  read device
  ifconfig $device down
	macchanger -p $device
  ifconfig $device up
  Pause
}

# function to display menu
Show_Main_Menu() {
	clear
	echo -e "${BOLD}${BLUE}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo -e " MAC ADDRESS SPOOFER"
	echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${STD}"
	echo "1. Random Mac Address"
	echo "2. Specific Mac Address"
  echo "3. Show Current Mac Address"
  echo "4. Reset To Original Mac Address"
	echo "5. Exit"
}

Read_Options() {
	local choice
  echo -e "${BOLD}${ORANGE}Enter choice [1 - 5]${STD}"
  read choice
	case $choice in
		1) Random ;;
		2) clear ; Specific ;;
    3) Current ;;
    4) Original ;;
		5) exit 0;;
		*) echo -e "${BOLD}${LIGHTRED}Error...${STD}" && sleep 1 && clear
	esac
}
# -----------------------------------
# Main logic - infinite loop
# ------------------------------------
while true
do

	Show_Main_Menu
	Read_Options
done
