#!/bin/bash
# mes fonctions


server_name=$(hostname)

function memory_check() {
  echo ""
	echo "Utilisation de la memoire sur ${server_name} : "
	free -h
	echo ""
}

function cpu_check() {
    echo ""
	echo "Chage du CPU sur ${server_name} : "
    echo ""
	uptime
    echo ""
}

function tcp_check() {
    echo ""
	echo "Connections TCP sur ${server_name}: "
    echo ""
	cat  /proc/net/tcp | wc -l
    echo ""
}

function kernel_check() {
    echo ""
	echo "Version du noyau sur ${server_name} is: "
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

function checkuid()
{
  if [ "$UID" -ne "$1" ]

    then
          echo -e "${RED} [ ERROR ]" "${NC} you must be root to install the server"
          exit 0

    else
          echo -e "${GREEN} [ OK ]" "${NC} UID ok, install in progress..."

fi
}

function espace_disque()
{
for disk in $(df |grep dev |grep -v tmpfs |grep -v udev| awk -F" " '{print $1}' | cut -d/ -f3)
    do
      echo $disk

        space_use=$(df | grep "$disk" | awk -F" " '{print $5}' | cut -d% -f1)

      echo $space_use
}
