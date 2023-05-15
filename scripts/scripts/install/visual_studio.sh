#!/bin/bash
source ~/scripts/colors.sh
PACKAGE_NAME="code"
COMMAND_NAME="code"
CONTINUE=true
URL="https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"

clear

if command -v "${COMMAND_NAME}" &> /dev/null
then
    CONTINUE=false
    VERSION=$($COMMAND_NAME --version | head -n 1)
    SHOW_WARNING "detectamos que ${PACKAGE_NAME} (${VERSION}) esta instalado, \n¿deseas desinstalarlo para instalar la última versión estable?${DEFAULT} ${GREEN}S${DEFAULT}i/${RED}N${DEFAULT}o\nesperando su respuesta: "
    read "USER_RESPONSE"
    
    if [ "$USER_RESPONSE" = "s" ] || [ "$USER_RESPONSE" = "S" ] || [ "$USER_RESPONSE" = "y" ] || [ "$USER_RESPONSE" = "Y" ]
    then
        sudo apt remove --purge $PACKAGE_NAME -y && SHOW_SUCCESS "desinstaló ${PACKAGE_NAME}"
        CONTINUE=true
    fi
fi


if $CONTINUE
then
    SHOW_INFO "Se procede a descargar la última versión estable"
    wget -O ~/Downloads/${PACKAGE_NAME}.deb ${URL} && SHOW_INFO "Descarga finalizada"
    SHOW_INFO "Se procede a instalar ${PACKAGE_NAME}"
    cd ~/Downloads && sudo dpkg -i $PACKAGE_NAME.deb
    rm ~/Downloads/$PACKAGE_NAME.deb -rfv
    VERSION=$($COMMAND_NAME --version | head -n 1)
    SHOW_SUCCESS "Se instaló la ultima versión estable de ${PACKAGE_NAME} (${VERSION})"
else
    SHOW_ERROR "se canceló la reinstalación de ${PACKAGE_NAME}"
fi

