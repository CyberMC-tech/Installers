#!/usr/bin/env python3

import argparse
import os
import time
import subprocess
import sys

version = "1.0.0"

FONTS = [
    "3270",
    "Agave",
    "AnonymousPro",
    "Arimo",
    "AurulentSansMono",
    "BigBlueTerminal",
    "BitstreamVeraSansMono",
    "CascadiaCode",
    "CodeNewRoman",
    "ComicShannsMono",
    "Cousine",
    "DaddyTimeMono",
    "DejaVuSansMono",
    "DroidSansMono",
    "EnvyCodeR",
    "FantasqueSansMono",
    "FiraCode",
    "FiraMono",
    "Gohu",
    "Go-Mono",
    "Hack",
    "Hasklig",
    "HeavyData",
    "Hermit",
    "IBMPlexMono",
    "iA-Writer",
    "Inconsolata",
    "InconsolataGo",
    "InconsolataLGC",
    "Iosevka",
    "IosevkaTerm",
    "JetBrainsMono",
    "Lekton",
    "LiberationMono",
    "Lilex",
    "Meslo",
    "Monofur",
    "Monoid",
    "Mononoki",
    "MPlus",
    "NerdFontsSymbolsOnly",
    "Noto",
    "OpenDyslexic",
    "Overpass",
    "ProFont",
    "ProggyClean",
    "RobotoMono",
    "ShareTechMono",
    "SourceCodePro",
    "SpaceMono",
    "Terminus",
    "Tinos",
    "Ubuntu",
    "UbuntuMono",
    "VictorMono",
]

bold = "\033[1m"
blink = "\033[5m"
normal = "\033[0m"
aqua = "\033[36m"
lightred = "\033[91m"
lightgreen = "\033[92m"
lightyellow = "\033[93m"
lightblue = "\033[94m"
lightaqua = "\033[96m"


def _all():
    print(f"\n{lightred}{blink}{bold}CAUTION: {normal}This will install every font.\n")
    print(f"\nTo exit press{lightgreen} ENTER{normal} ")
    confirm = input(f'\nIf you wish to continue please type "{lightred}YES{normal}" : ')
    if confirm == "YES":
        for font in FONTS:
            _check(font)
            _install(font)

    else:
        print(f"\nAborting installation...")
        time.sleep(1)
        exit(1)


def _rmdir(font):
    DIR = dir + font
    global choice_all
    valid_choice = False
    if choice_all:
        print(f"\nRemoving directory for font {aqua}{font}{normal}...")
        subprocess.run(["sudo", "rm", "-rf", DIR])
        _install(font)
    else:
        while not valid_choice:
            print(f"\nThe directory for font {aqua}{font}{normal} already exists")
            print("\nwould you like to remove it and continue?")
            choice = input(
                f"\n[{lightgreen}A{normal}ll|{lightyellow}y{normal}es|{lightred}n{normal}o] : "
            ).lower()
            if choice in ["all", "a", ""]:
                choice_all = True
                valid_choice = True
            elif choice in ["yes", "y"]:
                valid_choice = True
                print(f"\nRemoving directory for font {aqua}{font}{normal}...")
                subprocess.run(["sudo", "rm", "-rf", DIR])
                _install(font)
            elif choice in ["no", "n"]:
                print("\nAborting installation...")
                time.sleep(1)
                exit(1)
            else:
                print("\n{lightyellow}Please enter a valid choice{normal} ")


def _install(font):
    URL = (
        "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/"
        + font
        + ".zip"
    )
    DIR = dir + font
    TEMP = "/tmp/" + font
    if os.path.isdir(DIR):
        _rmdir(font)
    else:
        print(f"\nInstalling {aqua}{font}{normal}...\n")
        subprocess.run(["sudo", "mkdir", "-p", DIR])
        subprocess.run(["wget", "-q", "--show-progress", URL, "-O", TEMP])
        print(f"\nMoving files to {lightblue}{DIR}{normal}")
        subprocess.run(["sudo", "unzip", "-qq", TEMP, "-d", DIR])
        subprocess.run(["sudo", "rm", "-rf", TEMP])


def _check(font):
    if font in FONTS:
        pass
    else:
        print(f"\n{aqua}{font}{normal} is not a valid font. ")
        print(f"\nPlease ensure correct spelling and try again")
        print(f"\n{bold}{blink}{lightred}NOTE:{normal} case matters!! \n")
        time.sleep(2)
        exit(1)


def _dir_check(dir):
    if not dir.endswith("/"):
        dir += "/"
    return dir


def parse():
    parser = argparse.ArgumentParser(
        prog="install-nerd-font",
        description="Install Nerd Font(s) from the command line",
    )
    parser.add_argument("-a", "--all", action="store_true", help="Install all fonts")
    parser.add_argument(
        "-d",
        "--dir",
        type=str,
        default="/usr/share/fonts/truetype/",
        help="Install fonts to a different directory",
    )
    parser.add_argument("-f", "--font", nargs="+", help="The font you want to install")
    parser.add_argument(
        "-l", "--list", action="store_true", help="List all available fonts"
    )
    parser.add_argument(
        "-v", "--version", action="store_true", help="Print version and exit"
    )
    args = parser.parse_args()

    global dir
    dir = _dir_check(args.dir)

    if args.list:
        print(f"\n{lightblue}Available Fonts: {normal}")
        num = 1
        for font in FONTS:
            print(f"{num}.) {lightaqua}{font}{normal}")
            num += 1

    if args.all:
        _all()

    if args.font:
        fonts = args.font
        for font in fonts:
            _check(font)
        for font in fonts:
            _install(font)
        print(f"\nFonts have been successfully installed\n")
        time.sleep(1)
        exit(0)

    if args.version:
        print(f"\nVersion: {version}\n")


def main():
    global choice_all
    choice_all = False
    if len(sys.argv) == 1:
        sys.argv.append("-h")
        parse()
    else:
        parse()


if __name__ == "__main__":
    main()
