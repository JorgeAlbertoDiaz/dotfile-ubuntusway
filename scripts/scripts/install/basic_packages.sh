#!/bin/bash
source ~/scripts/colors.sh
clear
VAR=""
PACKAGES=""

packageNames=(
    "apt-transport-https"
    "ca-certificates"
    "cargo"
    "cmake"
    "curl"
    "default-jre"
    "fd-find"
    "ffmpegthumbnailer"
    "figlet"
    "foot"
    "fzf"
    "gettext"
    "gimp"
    "git"
    "gnupg"
    "graphviz"
    "inkscape"
    "libapache2-mod-php8.1"
    "libmysqlclient-dev"
    "libxext-dev"
    "lsb-release"
    "lua5.2"
    "mysql-server-8.0"
    "neofetch"
    "ninja-build"
    "poppler-utils"
    "python3"
    "python3-all"
    "python3-django"
    "python3-neovim"
    "python3-pip"
    "python3-venv"
    "ripgrep"
    "rust-all"
    "screenfetch"
    "software-properties-common"
    "speedtest-cli"
    "stow"
    "texlive-latex-extra"
    "tmux"
    "unzip"
    "vim"
    "wget"
    "xclip"
)

SHOW_INFO "Verificando paquetes instalados:"
for PACKAGE in ${packageNames[@]}; do
	dpkg -s $PACKAGE &> /dev/null

	if [ $? -ne 0 ]
	then
		printf "\n󰅙 ${PACKAGE} : ${RED}no instalado${DEFAULT}"
		VAR+="\n ${PACKAGE}"
		PACKAGES+="${PACKAGE} "
	else
		printf "\n ${PACKAGE} : ${GREEN}instalado${DEFAULT}"
	fi
done

INSTALL=""
if [[ $VAR ]]
then
  printf "\n"
  SHOW_WARNING "Se instalaran los siguientes paquetes:"
	printf "${GREEN}${VAR}\n${DEFAULT}"
  printf "¿Deseas continuar con la instalación? ${GREEN}S${DEFAULT}i/${RED}N${DEFAULT}o\nesperando su respuesta: "
  read "USER_RESPONSE"
  if [ "$USER_RESPONSE" = "s" ] || [ "$USER_RESPONSE" = "S" ] || [ "$USER_RESPONSE" = "y" ] || [ "$USER_RESPONSE" = "Y" ]
  then
    INSTALL=true
  else
    INSTALL=false
  fi
else
	printf "${GREEN}Ya tienes estos paquetes instalados en tu sistema.${DEFAULT}\n\n"
fi

if $INSTALL
then
	sudo apt install -y $PACKAGES && SHOW_SUCCESS "Paquetes instalados!"
fi
