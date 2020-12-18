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
