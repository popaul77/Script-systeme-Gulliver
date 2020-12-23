#!/bin/bash

##############################################################
# BASH menu: script de test du systeme: Version 0.1 du 23/12/2020
# - Utilisation memoire
# - Charge CPU
# - Etat connexion internet
# - Version du noyau
# Volume de données dans le/s disques dur ou dans la partition var
##
### jpg@popaul77.org
###############################################################

# Importation des fonctions et des couleurs
source fonctions.sh
source couleurs

## c'est parti
clear; checkuiduser

##
# menu options
##

incorrect_selection() {
  echo $(ColorRed 'Selection incorrecte! Essaye encore.')
}

press_enter() {
  echo ""
  echo -n " Appuyer sur Entrée pour continuer "
  read
  clear
}

menu(){
  echo ""
  echo -e "$(ColorCyanClair '########## [  MENU PRINCIPAL ] ##########')"
  echo ""
echo -ne " Information systeme
        $(ColorGreen '1)') Utilisation mémoire
        $(ColorGreen '2)') Charge CPU
        $(ColorGreen '3)') Information réseau
        $(ColorGreen '4)') Version du noyau
        $(ColorGreen '5)') Espace disque disponible
        $(ColorGreen '6)') Controle volume dossier ou partition
        $(ColorGreen '7)') Tous les tests
        $(ColorGreen '8)') Espace_/var disponible (ROOT)
        ________________________________________
        $(ColorGreen '0)') Sortir du menu

        $(ColorBlue 'Choisir une option:') "

        read a

    echo""

        case $a in
	        1) memory_check ; menu ;;
	        2) cpu_check ; menu ;;
	        3) internetok ; menu ;;
	        4) kernel_check ; menu ;;
          5) checkdisk ; menu ;;
          6) ncdudiskusage ; menu ;;
	        7) all_checks ; menu ;;
          8) checkuid ; usedisk ; menu ;;
          0) exit 0 ;;
          * ) clear ; incorrect_selection ; press_enter ;;
		    esac
}

# Appel de la fonction Menu

until [ "$a" = "0" ]; do
    menu
done
