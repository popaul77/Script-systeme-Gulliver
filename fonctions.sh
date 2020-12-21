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
  if [ "$UID" -ne "0" ]

    then
          echo -e "$(ColorRed '[ ERROR ]')" "Vous devez etre root pour faire cette installation"
          exit 0

    else
          echo -e "$(ColorGreen '[ OK ]')" "UID ROOT ok, L'installation peut continuer........"

fi
}

############# serie a tester ####################""

function checkuiduser()
{
  if [ "$UID" -eq "0" ]

    then
          echo -e "$(ColorRed '[ ERROR ]')" "Vous ne devez etre root pour lancer cette commande"
          exit 0

    else
          echo -e "$(ColorGreen '[ OK ]')" "UID USER ok, L'execution peut continuer........"

fi
}


function checkdisk()
{
  for disk in $(df |grep dev |grep -v tmpfs |grep -v udev| awk -F" " '{print $1}' | cut -d/ -f3)
      do
        echo $disk

          space_use=$(df -Th | grep "$disk" | awk -F" " '{print $4 " / " $5}' | cut -d% -f1)

        echo $space_use
      done
}

function usedisk()
{
    espacevar=$(du -sh /var)
    espacevarlib=$(du -sh /var/lib)
    espacevarcache=$(du -sh /var/cache)

    echo "Espace disque utilisé de :"
    echo $espacevarlib
    echo $espacevarlib
    echo $espacevarcache

}

function internetok()
{
  nc -z 8.8.8.8 53  >/dev/null 2>&1
    online=$?
      if [ $online -eq 0 ]; then
          echo echo -e "$(ColorGreen '[ OK ]')" "Connexion internet active"
        else
          echo echo -e "$(ColorRed '[ ERROR ]')" " Pas de connexion internet "
      fi
}
