#!/bin/bash

TEMP=$(mktemp)
FONTS=(
	"3270"
	"Agave"
	"AnonymicePro"
	"Arimo"
	"AurulentSansM"
	"BigBlueTerm"
	"BitstromWera"
	"CaskaydiaCove"
	"BlexMono"
	"CodeNewRoman"
	"ComicShannsMono"
	"Cousine"
	"DaddyTimeMono"
	"DejaVuSansM"
	"DroidSansM"
	"EnvyCodeR"
	"FantasqueSansM"
	"FiraCode"
	"FiraMono"
	"GohuFont"
	"GoMono"
	"Hack"
	"Hasklug"
	"HeavyData"
	"Hurmit"
	"iMWriting"
	"Inconsolata"
	"InconsolataGo"
	"InconsolataLGC"
	"Iosevka"
	"IosevkaTerm"
	"JetBrainsMono"
	"Lekton"
	"LiterationMono"
	"Lilex"
	"MesloLG"
	"Monofur"
	"Monoid"
	"Mononoki"
	"MPlus"
	"Noto"
	"OpenDyslexic"
	"Overpass"
	"ProFont"
	"ProggyClean"
	"RobotoMono"
	"ShureTechMono"
	"SauceCodePro"
	"SpaceMono"
	"Symbols"
	"Terminess"
	"Tinos"
	"Ubuntu"
	"UbuntuMono"
	"VictorMono"
)

# COLOR VARIABLES
bold=$(echo -en "\e[1m")
blink=$(echo -en "\e[5m")
normal=$(echo -en "\e[0m")
aqua=$(echo -en "\e[36m")
lightred=$(echo -en "\e[91m")
lightgreen=$(echo -en "\e[92m")
lightyellow=$(echo -en "\e[93m")
lightaqua=$(echo -en "\e[96m")

_help() {
	cat <<EOF
  Usage: $0 [OPTION]... -f, --font <font_name> | -a, --all

  -a, --all       Install all fonts
  -f, --font      Follow with <font_name>
  -h, --help      Print this dialog and exit
  -l, --list      List all available fonts

  EXAMPLE: $0 -f VictorMono
           $0 -f Agave CodeNewRoman
           $0 -a

EOF
	exit 0
}

unknown_response() {
	echo -e "\n${lightred}Error: ${normal}Unknown response"
	sleep 2
	_help
}

_all() {
	echo -e "\n${lightred}${blink}${bold}CAUTION: ${normal}This will install every font.\n"
	printf "\nTo continue please type \"YES\" :"
	read -r confirm
	confirm=$(${confirm::1} | tr '[:upper:]' '[:lower:]')
	if [[ "$confirm" == "y" ]]; then
		for i in "${FONTS[@]}"; do
			$0 -f "$i"
		done
	elif [[ "$confirm" == "n" ]]; then
		echo -e "\nAborting installation..."
		sleep 1
		exit 0
	else
		_unknown_response
	fi
}

_list_fonts() {
	local num=1
	for i in "${FONTS[@]}"; do
		echo -e "${lightaqua}${num}.) ${lightyellow}${i}${normal}"
		((num++))
	done

}

_install() {
	sudo mkdir -p "$DIR"
	wget -q --show-progress "$URL" -O "$TEMP"
	sudo unzip "$TEMP" -d "$DIR"
	sudo rm -rf "$TEMP"
	echo "${aqua}$font Nerd Font ${normal}has been successfully installed."
	sleep 1
	exit 0
}

_begin() {
	if [[ -d "$DIR" ]]; then
		echo -e "\n${DIR} already exists."
		echo -e "\nWould you like to remove it and try again?\n"
		echo -en "[${lightgreen}Yes${normal}|${lightred}no${normal}] :"
		read -r ans
		_check_ans
	else
		_install
	fi
}

_check_ans() {
	case "$ans" in
	yes | Yes | YES | Y | y | " ")
		sudo rm -rf "$DIR" && _install
		;;
	no | No | NO | n | N)
		echo -e "\nAborting installation"
		sleep 1
		exit 1
		;;
	*)
		_valid_answer
		;;
	esac
}

_valid_answer() {
	echo -e "\n Please enter a valid response"
	echo -e "\nWould you like to remove it and try again?\n"
	printf "[Yes|no] :"
	read -r ans
	_check_ans
}

if (($# > 0)); then
	case $1 in
	-l | --list)
		_list_fonts
		;;
	-h | --help)
		_help
		;;
	-f | --font)
		font="$2"
		URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/${font}.zip"
		DIR="/usr/share/fonts/truetype/${font}"
		_begin
		;;
	-a | --all)
		_all
		;;
	esac
else
	_help
fi
