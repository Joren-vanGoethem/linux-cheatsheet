#!/usr/bash
source /root/Desktop/Bash_Scripts/sources/Variables.sh

Show_Main_Menu() {
	clear
	echo -e "${BOLD}${BLUE}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo -e " KALI MENU - NETWORK ATTACKS - JVG "
	echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${STD}"
	echo "1. Deauthentication Attack"
	echo "2. Mac Spoofer"
  echo "3. Evil Twin Attack"
	echo "4. Arp Poison Attack"
  echo "5. Coming soon - Brute Force Wireless Password"
  echo "6. Coming soon"
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
