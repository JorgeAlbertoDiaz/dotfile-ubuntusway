#!/bin/bash
source ~/scripts/colors.sh
PACKAGE_NAME="docker-ce"
COMMAND_NAME="docker"
CONTINUE=true
GIT_URL="https://github.com/neovim/neovim"

clear

if command -v "${COMMAND_NAME}" &> /dev/null
then
    CONTINUE=false
    VERSION=$($COMMAND_NAME --version | head -n 1)
    SHOW_WARNING "detectamos que ${COMMAND_NAME} (${VERSION}) esta instalado, \n¿deseas desinstalarlo para instalar la última versión estable?${DEFAULT} ${GREEN}S${DEFAULT}i/${RED}N${DEFAULT}o\nesperando su respuesta: "
    read "USER_RESPONSE"
    
    if [ "$USER_RESPONSE" = "s" ] || [ "$USER_RESPONSE" = "S" ] || [ "$USER_RESPONSE" = "y" ] || [ "$USER_RESPONSE" = "Y" ]
    then
        SHOW_INFO "Remueve instaciones viejas de docker"
        sudo apt remove --purge docker docker-engine docker.io containerd runc $PACKAGE_NAME -y && SHOW_SUCCESS "se desinstaló ${PACKAGE_NAME}"
        CONTINUE=true
    fi
fi


if $CONTINUE
then
    SHOW_INFO "Descarga y agrega la llave GPG de Docker al repositorio"
    sudo mkdir -p /etc/apt/keyrings && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    SHOW_INFO "Agrega el repositorio de Docker al Sistema"
	  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    SHOW_INFO "Se ejecuta apt update" 
    sudo apt update
    SHOW_INFO "Instala Docker Engine y Docker Compose"
	  sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin docker-compose -y
    SHOW_INFO "Administrar docker como un usuario sin ser root"
    # sudo groupadd docker # Esto generalmente se crea solo
    sudo usermod -aG docker $USER
    newgrp docker
    SHOW_INFO "Habilito el servicio para que se inicie junto al equipo"
    sudo systemctl start $COMMAND_NAME.service
    sudo systemctl enable $COMMAND_NAME.service

    VERSION=$($COMMAND_NAME --version | head -n 1)
    SHOW_SUCCESS "Se instaló la ultima versión estable de ${COMMAND_NAME} (${VERSION})"
else
    SHOW_ERROR "se canceló la reinstalación de ${COMMAND_NAME}"
fi
