#!/bin/bash

RED="\e[31m"
GREEN="\e[32m"
BLUE="\e[34m"
ENDCOLOR="\e[0m"

echo -e "${GREEN}
    ___       ___       ___       ___   
   /\  \     /\  \     /\  \     /\  \     /\__\  
   \:\  \   /::\  \   /::\  \   /::\  \   /:/  /  
   /::\__\ /::\:\__\ /::\:\__\ /::\:\__\ /:/__/   
  /:/\/__/ \/\::/  / \:\::/  / \:\:\/  / \:\  \   
  \/__/      /:/  /   \::/  /   \:\/  /   \:\__\  
             \/__/     \/__/     \/__/     \/__/

            ++ Version: 1.0 ++
    Developed & Maintain by Tabel Developers.
${ENDCOLOR}
"

echo "Please choose your distro: "
echo "When using tabel we expect you already have a working install of your selected distro. "


supported_distros=("Arch Linux" "Debian/Ubuntu" "Fedora" "Quit/Exit")
select opt in "${supported_distros[@]}"
do
    case $opt in
        "Arch Linux")
            echo -e "${BLUE}Running Arch basic setup..${ENDCOLOR}"

            ## Basic tools that I think should be installed by default on any machine. 
            echo -e "${BLUE}:: Installing Git, curl, nano, wget, zsh & fakeroot..${ENDCOLOR}"
            sudo pacman -S --noconfirm git curl wget zsh nano fakeroot

            echo -e "${BLUE}:: Installing tar, gzip, bzip2, unzip, unrar & p7zip.. ${ENDCOLOR}"
            sudo pacman -S --noconfirm tar gzip bzip2 unzip unrar p7zip
            ## Flatpak support
            echo -e "${BLUE}Installing and adding flatpak support..${ENDCOLOR}"
            sudo pacman -S --noconfirm flatpak 

            ## Installing yay-bin 
            echo -e "${BLUE}:: Installing Yay (AUR Helper)${ENDCOLOR}"

            ## This directory is going to store everything during the setup. 
            echo "Making directory to store files.."
            mkdir tabel_arch_install 
            cd tabel_arch_install

            ## Cloning and building the AUR
            echo "Downloading yay-bin from AUR.."
            git clone https://aur.archlinux.org/yay-bin.git
            cd yay-bin

            echo "Building package.."
            makepkg -si

            ## Installing fonts

            echo -e "${GREEN}:: Installing fonts...${ENDCOLOR}"

            sudo pacman --noconfirm -S noto-fonts-cjk noto-fonts-extra noto-fonts-emoji ttf-dejavu

            echo -e "${GREEN}:: Basic Arch setup: Done. ${ENDCOLOR}"
            echo " To install gaming packages please choose ArchGaming.."

            ;;
        "Debian/Ubuntu")
            echo "Selected Debian/Ubuntu.."
            ;;
        "Fedora")
            echo "Selected Fedora.."
            ;;
        "Quit/Exit")
            break
            ;;
        *) echo "Invalid option selected, $REPLY is a not a value.";;
    esac
done