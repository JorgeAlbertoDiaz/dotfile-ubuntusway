#!/bin/bash
source ~/scripts/colors.sh
PACKAGE_NAME="neovim"
COMMAND_NAME="nvim"
CONTINUE=true
GIT_URL="https://github.com/neovim/neovim"

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
    SHOW_INFO "Se procede a descargar desde github la última versión estable"
    cd ~/Downloads && git clone $GIT_URL $PACKAGE_NAME
    SHOW_INFO "Se procede a compilar ${PACKAGE_NAME}"
    cd ~/Downloads/$PACKAGE_NAME && git checkout stable && make CMAKE_BUILD_TYPE=RelWithDebInfo
    SHOW_INFO "Se procede a instalar ${PACKAGE_NAME}"
    cd build && cpack -G DEB && sudo dpkg -i nvim-linux64.deb 
    rm ~/Downloads/$PACKAGE_NAME -rfv
    VERSION=$($COMMAND_NAME --version | head -n 1)
    SHOW_SUCCESS "Se instaló la ultima versión estable de ${PACKAGE_NAME} (${VERSION})"
else
    SHOW_ERROR "se canceló la reinstalación de ${PACKAGE_NAME}"
fi
