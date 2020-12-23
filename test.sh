#!/bin/bash

##
# script de test pour les fonctions s
# ceci propose une autre solution pour executer toutes les fonctions ci desous sans
# avoir besoin de choisir
### jpg@popaul77.org
###############################################################

# Source externe
source couleurs
source fonctions.sh


# Début du script
clear; checkuiduser
echo ""
echo "########## Conversion jpg 2 png #########################################"
convertjpg2png
echo ""
echo "########## Verification de l'état de la connexion internet ##############"
internetok
echo ""
echo "########## Etat occupation partition ou dossier #########################"
ncdudiskusage
echo ""
echo "########## Etat occupation disque dur ###################################"
checkdisk
echo ""
echo "########## Verification du volume de données dans /var ##################"
checkuid; usedisk
