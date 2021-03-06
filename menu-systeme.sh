#!/bin/bash
##


# BASH menu: script de test du systeme:
# - Utilisation memoire
# - Charge CPU
# - Nombre de connections TCP
# - Version du noyau
##

server_name=$(hostname)

function memory_check() {
  echo ""
	echo "Memory usage on ${server_name} is: "
	free -h
	echo ""
}

function cpu_check() {
    echo ""
	echo "CPU load on ${server_name} is: "
    echo ""
	uptime
    echo ""
}

function tcp_check() {
    echo ""
	echo "TCP connections on ${server_name}: "
    echo ""
	cat  /proc/net/tcp | wc -l
    echo ""
}

function kernel_check() {
    echo ""
	echo "Kernel version on ${server_name} is: "
	echo ""
	uname -r
    echo ""
}

function all_checks() {
	memory_check
	cpu_check
	tcp_check
	kernel_check
}

##
# Color Variables
##
green='\e[32m' # color green
blue='\e[34m'  # color blue
clear='\e[0m'  # back 2 color system
red='\e[0;31m'  # color red

##
# Color Functions
##

ColorGreen(){
	echo -ne $green $1 $clear
}
ColorBlue(){
	echo -ne $blue $1 $clear
}
ColorRed(){
	echo -ne $red $1 $clear
}


##
# menu optios
##

incorrect_selection() {
  echo $(ColorRed 'Incorrect_selection! Try again.')
}

press_enter() {
  echo ""
  echo -n " Press Enter to continue "
  read
  clear
}

menu(){
echo -ne " My First Menu
        $(ColorGreen '1)') Memory usage
        $(ColorGreen '2)') CPU load
        $(ColorGreen '3)') Number of TCP connections
        $(ColorGreen '4)') Kernel version
        $(ColorGreen '5)') Check All
        $(ColorGreen '0)') Exit
        $(ColorBlue 'Choose an option:') "

        read a
        case $a in
	        1) memory_check ; menu ;;
	        2) cpu_check ; menu ;;
	        3) tcp_check ; menu ;;
	        4) kernel_check ; menu ;;
	        5) all_checks ; menu ;;
		      0) exit 0 ;;
          * ) clear ; incorrect_selection ; press_enter ;;
        esac
}

# Call the menu function

until [ "$a" = "0" ]; do
    menu
done
