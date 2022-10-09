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

            echo -e "${GREEN}:: Installing wine dependencies....${ENDCOLOR}"
            echo -e "${GREEN}:: We use the Lutris wine dependencies list ${ENDCOLOR}"
            echo -e "${GREEN}:: Source here: https://github.com/lutris/docs/blob/master/WineDependencies.md${ENDCOLOR}"

            echo -e "${RED}::Enabling multilib (TESTING REQUIRED..)${ENDCOLOR}"

            sed -i 's/#\[multilib]/\[multilib]/g' /etc/pacman.conf

            sudo pacman -Syu --noconfirm

            sudo pacman -S --needed wine-staging giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls \
            mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse libgpg-error \
            lib32-libgpg-error alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo \
            sqlite lib32-sqlite libxcomposite lib32-libxcomposite libxinerama lib32-libgcrypt libgcrypt lib32-libxinerama \
            ncurses lib32-ncurses ocl-icd lib32-ocl-icd libxslt lib32-libxslt libva lib32-libva gtk3 \
            lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader

            echo -e "${GREEN}:: Wine/Lutris dependencies installed! ${ENDCOLOR}"

            echo -e "${GREEN}:: Installing fonts...${ENDCOLOR}"

            sudo pacman --noconfirm -S noto-fonts-cjk noto-fonts-extra noto-fonts-emoji ttf-dejavu

            echo -e "${GREEN}:: Basic Arch setup: SUCCESSFUL! ${ENDCOLOR}"
            ;;
        "Debian/Ubuntu")
            echo "Selected Debian/Ubuntu.."
            ;;
        "Fedora")
            echo "Selected Fedora.."
            echo -e "${BLUE}Welcome to Fedora, lets get going...${ENDCOLOR}"
            echo -e "${GREEN}:: Doing some magic to make dnf faster... (Password required)${ENDCOLOR}"
            echo 'max_parallel_downloads=10' | sudo tee -a /etc/dnf/dnf.conf

            echo -e "${GREEN}:: Starting system update process...${ENDCOLOR}"
            sudo dnf update -y 

            echo -e "${BLUE}Enabling a bunch of stuff, including Multimedia codecs, flatpak and RPMFushion${ENDCOLOR}"

            echo -e "${GREEN}:: Setting up flatpak... (You might need to enter your password)${ENDCOLOR}"
            sudo dnf install flatpak
            flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

            echo -e "${GREEN}:: Installing RPMFushion repo...${ENDCOLOR}"
            sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

            echo -e "${GREEN}:: Enabling Media codecs...${ENDCOLOR}"
            sudo dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel -y
            sudo dnf install lame\* --exclude=lame-devel -y 
            sudo dnf group upgrade --with-optional Multimedia -y

            echo -e "${GREEN}:: Installing basic software...${ENDCOLOR}"
            sudo dnf install p7zip git curl wget

            echo ":: All good, installing successfull"
             echo -e "${RED}:: A REBOOT IS REQUIRED, PLEASE DO SO BEFORE DOING ANYTHING ELSE.${RED}"
            ;;
        "Quit/Exit")
            break
            ;;
        *) echo "Invalid option selected, $REPLY is a not a value.";;
    esac
done