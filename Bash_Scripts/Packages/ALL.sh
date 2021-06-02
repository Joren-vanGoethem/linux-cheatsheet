/#!/usr/bash
source /root/Desktop/Bash_Scripts/sources/Variables.sh

Show_Main_Menu() {
	clear
	echo -e "${BOLD}${BLUE}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo -e " KALI PACKAGE INSTALLER"
	echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${STD}"
	echo "1. Install All"
	echo "2. Install Certain Packages"
  echo "3. What Is Already Installed"
	echo "4. Exit"
}

Read_Options() {
	local choice
  echo -e "${BOLD}${ORANGE}Enter choice [1 - 5]${STD}"
  read choice
	case $choice in
		1) All ;;
		2) Certain ;;
    3) Installed ;;
		5) exit 0;;
		*) echo -e "${BOLD}${LIGHTRED}Error...${STD}" && sleep 1 && clear
	esac
}

All() {
  sudo apt install macchanger ethtool rfkill aircrack-ng
}

Certain() {

}

Installed() {

}
