#!/bin/bash

###############################################################
# mes fonctions Version 0.1 du 23/12/2020
### jpg@popaul77.org
###############################################################

## nom de la machine
server_name=$(hostname)

#_________________________________________________
# Verifier que ncdu est installé
function ncduinstall() {
  if [ $(dpkg-query -W -f='${Status}' ncdu 2>/dev/null | grep -c "ok installed") -eq 0 ];
  then
    echo -e "$(ColorRed '[ Le paquet NCDU n est pas installé. Installer le avant de continuer ]')"
    exit 0
  fi
}

#_________________________________________________
# Etat de la memoire
function memory_check() {
  echo ""
	 echo -e "${orange} [ _____ [ Utilisation de la memoire sur${clear}${red} ${server_name}${clear}${orange} _____ ]${clear} "
  echo ""
	   free -h
	echo ""
}

#_________________________________________________
# Charge du Microprocesseur
function cpu_check() {
    echo ""
	     echo -e "${orange} [ _____ [ Chage du CPU sur${clear}${red} ${server_name}${clear}${orange} _____ ]${clear} "
    echo ""
	     uptime
    echo ""
}

#_________________________________________________
# Nombres de connexion active (pas utilisée dans le script info-systeme.sh)
function tcp_check() {
    echo ""
	      echo -e "${orange} [ _____ [ Connections TCP sur${clear}${red} ${server_name}${clear}${orange} _____ ]${clear} "
    echo ""
	     cat  /proc/net/tcp | wc -l
    echo ""
}

#_________________________________________________
# Version du noyau actif
function kernel_check() {
  echo ""
	   echo -e "${orange} [ _____ [ Version du noyau sur${clear}${red} ${server_name}${clear}${orange} _____ ]${clear} "
	echo ""
	   uname -r
  echo ""
}

#_________________________________________________
# Tous les tests
function all_checks() {
	memory_check
	cpu_check
	internetok
	kernel_check
  checkdisk
  ncdudiskusage
}

#_________________________________________________
# suis je ROOT sur cette machine
function checkuid()
{
if [ "$UID" -ne "0" ]
    then
          echo -e "$(ColorRed '[ ERROR ]')" "Vous devez etre root pour lancer cette commande......."
          exit 0
    else
          echo -e "$(ColorGreen '[ UID ROOT OK ]')" " L'execution peut continuer........"
fi
}

#_________________________________________________
# Qui suis je sur cette machine
function checkuiduser()
{
  if [ "$UID" -eq "0" ]

    then
          echo -e "$(ColorRed '[ ERROR ]')" "Vous ne devez pas etre root pour lancer cette commande"
          exit 0

    else
          echo -e "$(ColorGreen '[ UID USER OK ]')" " L'execution peut continuer........"

fi
}

#_________________________________________________
# Verification de l'espace utilisé et disponible sur les disques de la machine
function checkdisk()
{
  echo ""
	   echo -e "${orange} [ _____ [ Espace disque disponible sur${clear}${red} ${server_name}${clear}${orange} _____ ]${clear} "
	echo ""

  for disk in $(df |grep dev |grep -v tmpfs |grep -v udev| awk -F" " '{print $1}' | cut -d/ -f3)
      do
        echo -e "Pris / Dispo"
        echo $disk

          space_use=$(df -Th | grep "$disk" | awk -F" " '{print $4 " / " $5}' | cut -d% -f1)

        echo $space_use
      done
}

#_________________________________________________
# Verification du volume du dossier var
function usedisk()
{
  echo ""
     echo -e "${orange} [ _____ [ Volume utiliser dans /var de${clear}${red} ${server_name}${clear}${orange} _____ ]${clear} "
  echo ""

    espacevar=$(du -sh /var)
    espacevarlib=$(du -sh /var/lib)
    espacevarcache=$(du -sh /var/cache)

    echo -e "$(ColorCyanClair '[ L éspace disque utilisé est de : ]')"
    echo $espacevar
    echo $espacevarlib
    echo $espacevarcache
}

#_________________________________________________
# Verification de l'etat de la connexion internet
function internetok()
{
echo ""
  #echo -e "$(ColorOrange '########## [  Etat de la connexion internet ] ##########')"
  echo -e "${orange} [ _____  Etat de la connexion internet sur${clear}${red} ${server_name}${clear}${orange} _____ ]${clear} "
echo ""

  nc -z 8.8.8.8 53  >/dev/null 2>&1
    online=$?
      if [ $online -eq 0 ]; then
          echo -e "$(ColorGreen '[ OK ]')" "Connexion internet active sur:"
            ip -o -4 addr | awk '!/^[0-9]*: ?lo|link\/ether/{print $2" "$4}'

          echo -e "$(ColorGreen '[ IP EXTERNE ]')" "Adresse IP du routeur:"
            curl ifconfig.me

            echo ""

              if [ $? -eq 0 ]; then
                echo -e "$(ColorGreen '[ ACCES INTERNET OK ]')"
              else
                echo -e "$(ColorRed '[ ACCES INTERNET FAILED ]')"
              fi

        else
          echo echo -e "$(ColorRed '[ ERROR ]')" " Pas de connexion internet "
      fi
}

#_________________________________________________
# Conversion d'images par lot de jpg a png modifiable juste en changeant l'extension
function convertjpg2png()
{
  echo ""
    echo -e "${orange} [ _____  Convertion d images jpg vers png  _____ ]${clear}"
  echo ""

  MONDOSSIER=$(pwd)

  echo -e "$(ColorOrange '[ Entrer le nom du dossier contenant les images .jpg a convertir: ]')"
  #echo -e "${green} [ Mettre le ${greenbold}chemin complet${clear}${green} du dossier. Exemple Images/test/ ]${clear} "
    read -p " Exemple Images/test/ : " Entrer
      cd $HOME/$Entrer
    echo ""
    for image in *.jpg; do
        convert "$image" "${image%.jpg}.png"; echo “image $image converted to ${image%.jpg}.png ”;
    done

  cd $MONDOSSIER
}

#_________________________________________________
# Utilisation de ncdu pour connaitre l'etat d'occupation des dossiers
function ncdudiskusage()
{
  echo ""
      echo -e "${orange} [ _____ [ Controle volume dossier ou partition sur ${clear}${red} ${server_name}${clear}${orange} _____ ]${clear} "
  echo ""

  echo -e "$(ColorGreen '[ Pour sortir de l interface ncurse appuyer sur "q" ]')"
  echo ""
  echo -e "$(ColorOrange '[ Entrer le chemin du dossier a scaner: ]')"
    read -p " Exemple /var/log/ : " Entrer
        ncdu $Entrer
}

#_________________________________________________
#Renommer des fichiers en masse (remplace un espace par un _ )
#ls|while read file;do mv "$file" "$(echo "$file"|sed -e 's/\ /_/g')"; done
function rename()
{
ls | while read file
  do
      mv "$file" "$(echo "$file" | sed -e 's/\ /_/g')"
  done 2>/dev/null
}

#_________________________________________________
#lister les fichiers .txt contenant un texte precis.
function find-texte ()
{
  #find . -type f \( -iname '*.txt' -o -iname '*.pp' \) -print0 | xargs -0 grep -i "$1"
  #find . -type f \( -iname '*.txt' \) -print0 | xargs -0 grep -i "$1"

  grep $1 *.txt | cut -d: -f1 | more
}

#_________________________________________________
#
