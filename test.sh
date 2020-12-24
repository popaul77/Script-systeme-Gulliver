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
echo "_________________________________________________________"
convertjpg2png
echo ""
echo "_________________________________________________________"
internetok
echo ""
echo "_________________________________________________________"
ncdudiskusage
echo ""
echo "_________________________________________________________"
checkdisk
echo ""
echo "_________________________________________________________"
checkuid; usedisk
