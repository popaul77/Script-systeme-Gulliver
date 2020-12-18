#!/bin/bash
##


# BASH menu: script de test du systeme:
# - Utilisation memoire
# - Charge CPU
# - Nombre de connections TCP
# - Version du noyau
##


# Importation des fonctions

source fonctions.sh
source couleurs

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
echo -ne " Information systeme
        $(ColorGreen '1)') Utilisation mémoire
        $(ColorGreen '2)') Charge CPU
        $(ColorGreen '3)') Nombre de connections TCP
        $(ColorGreen '4)') Version du noyau
        $(ColorGreen '5)') Tous les tests
        $(ColorGreen '0)') Sortir du script
        $(ColorBlue 'Choisir une option:') "

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

# Appel de la fonction Menu

until [ "$a" = "0" ]; do
    menu
done
