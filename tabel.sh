#!/bin/bash

RED="\e[31m"
GREEN="\e[32m"
BLUE="\e[34m"
PURPLE='\033[0;35m'
ENDCOLOR="\e[0m"

echo -e "${PURPLE}
        ──────▄▀▄─────▄▀▄
        ─────▄█░░▀▀▀▀▀░░█▄
        ─▄▄──█░░░░░░░░░░░█──▄▄
        █▄▄█─█░░▀░░┬░░▀░░█─█▄▄█
==========================================
|████████╗░█████╗░██████╗░███████╗██╗░░░░░|
|╚══██╔══╝██╔══██╗██╔══██╗██╔════╝██║░░░░░|
|░░░██║░░░███████║██████╦╝█████╗░░██║░░░░░|
|░░░██║░░░██╔══██║██╔══██╗██╔══╝░░██║░░░░░|
|░░░██║░░░██║░░██║██████╦╝███████╗███████╗|
|░░░╚═╝░░░╚═╝░░╚═╝╚═════╝░╚══════╝╚══════╝|
================ v2.0 ====================
============= By Raif C. =================
${ENDCOLOR}
"

echo -e "${RED}When using tabel we expect you already have a working install of your selected distro.${ENDCOLOR}"
echo "Please choose your distro: "


supported_distros=("Arch Linux" "Ubuntu" "Fedora" "Update" "Quit/Exit")
select opt in "${supported_distros[@]}"
do
    case $opt in
        "Arch Linux")
            echo -e "${BLUE}Running Arch basic setup..${ENDCOLOR}"

            ## Basic tools that I think should be installed by default on any machine. 
            echo -e "${BLUE}:: Installing Git, curl, nano, wget, zsh & fakeroot..${ENDCOLOR}"
            sudo pacman -S --noconfirm git curl wget zsh nano fakeroot

            echo -e "${BLUE}:: Installing Unzip, unrar & p7zip.. ${ENDCOLOR}"
            sudo pacman -S --noconfirm tar unzip unrar p7zip

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

            notify-send --app-name=Tabel --expire-time=10000 "Arch setup complete, goodbye"

            ;;
        "Ubuntu")
            echo "Selected Ubuntu.."
            
            echo -e "${GREEN}:: Perfoming system update, this may take a moment...${ENDCOLOR}"
            sudo apt update 
            sleep 1
            sudo apt upgrade -y 

            echo -e "${BLUE}:: Enabling Multimedia Media codecs... ${ENDCOLOR}"
            echo -e "${RED}:: The following package may require additional confirmation, please press <OK> when shown..${ENDCOLOR}"
            sleep 3
            sudo apt install ubuntu-restricted-extras -y 
            
            echo -e "{BLUE}:: Installing unzip, unrar, p7zip, neofetch${ENDCOLOR}"            
            sudo apt install p7zip unrar unzip neofetch -y

            echo -e "{BLUE}:: Installing Nala... ${ENDCOLOR}"

            sudo apt install nala 
            
            echo -e "${RED}The following will be removed: Firefox provided by snap ${ENDCOLOR}"
            sudo snap remove firefox

            ## This will add Firefox's own Debian repo and use that instead of Firefox snap
            echo -e "${RED}:: Installing and enabling Firefox from mozillateam/ppa...${ENDCOLOR}"
            sudo add-apt-repository ppa:mozillateam/ppa

            echo '
Package: *
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001
' | sudo tee /etc/apt/preferences.d/mozilla-firefox
            
            echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";' | sudo tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox

            echo -e "${GREEN}:: Installing Firefox (deb package)...${ENDCOLOR}"
            
            sudo apt install firefox -y

            echo -e "${GREEN}:: Installing flatpak ${ENDCOLOR}"\

            sudo apt install gnome-software gnome-software-plugin-flatpak flatpak -y
            
            echo -e "${GREEN}:: Enabling flathub support... ${ENDCOLOR}"
            echo -e "${RED}:: Password authentication for addition of flatpak remote. ${ENDCOLOR}"
            sleep 3
            flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

            echo -e "${RED}:: The following packages will be disabled and removed: Snapd, snap, snap-store ${ENDCOLOR}"
            sudo systemctl disable snapd.service
            sudo systemctl disable snapd.socket
            sudo systemctl disable snapd.seeded.service

            sudo snap remove $(snap list | awk '!/^Name|^core/ {print $1}')

            sudo apt autoremove --purge snapd

            sudo rm -rf /var/cache/snapd
            rm -rf ~/snap

            echo -e "Blocking ubuntu from accessing telemetry..."
            echo "Tabel will use a third-party tool called disable-ubuntu-telemetry developed by LamdaLamdaLamda!"
            echo "Some files will be cloned from Github, afterwards everything will be removed."

            mkdir tabel-ubuntu
            cd tabel-ubuntu
            git clone https://github.com/LamdaLamdaLamda/disable-ubuntu-telemetry.git
            
            cd disable-ubuntu-telemetry

            echo "The following script will be run in 5 seconds, feel free to check it yourself."

            cat disableUbuntuOptOut.sh

            sleep 5

            echo "Using sudo permission to run script.."

            sudo ./disableUbuntuOptOut.sh

            chmod +x disableUbuntuOptOut.sh

            ## Run command neofetch because why not :D
            neofetch 

            notify-send --app-name=Tabel "Ubuntu installation complete, please reboot your machine before performing any other task."
            ;;
        "Fedora")
            echo "Selected Fedora.."
            echo -e "${BLUE}Welcome to Fedora ${ENDCOLOR}"
            echo -e "${GREEN}:: Doing some magic to make dnf faster... (Password required)${ENDCOLOR}"
            echo -e "Checking if line is present first.."
            # Go into file and check if lines are there (>?)
        if grep -q 'max_parallel_downloads=10' /etc/dnf/dnf.conf || grep -q 'defaultyes' /etc/dnf/dnf.conf
            then
            echo "Lines are already enabled! :D"
        else
            echo "Doing magic.."
            echo 'max_parallel_downloads=10' | sudo tee -a /etc/dnf/dnf.conf
            echo 'defaultyes=True' | sudo tee -a /etc/dnf/dnf.conf
        fi

            echo -e "${GREEN}:: Starting system update process...${ENDCOLOR}"
            sudo dnf update -y
            
            echo "Hold up a second.."

            sleep 1

            echo -e "${BLUE}Enabling a bunch of stuff, including Multimedia codecs, flatpak and RPMFushion${ENDCOLOR}"

            echo -e "${GREEN}:: Setting up flatpak... (Password might be required!)${ENDCOLOR}"
            sudo dnf install flatpak
            flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

            echo -e "${GREEN}:: Installing RPMFushion repo...${ENDCOLOR}"
            sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

            echo -e "${GREEN}:: Enabling Media codecs...${ENDCOLOR}"
            sudo dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel -y
            sudo dnf install lame\* --exclude=lame-devel -y 
            sudo dnf group upgrade --with-optional Multimedia -y

            echo -e "${GREEN}:: Installing basic software...${ENDCOLOR}"
            sudo dnf install p7zip git curl wget neofetch -y 

            neofetch

            notify-send --app-name=Tabel --expire-time=10000 "Setup complete, please reboot your machine before performing any other task"

;;
        "Update")

            echo -e "${GREEN}Updating tabel... ${ENDCOLOR}"
            git fetch --all
            git reset --hard origin/ubuntu ## TODO: CHANGE TO MASTER
            notify-send --app-name=Tabel --expire-time=10000 "Tabel updated successfully"
            
break
;;
        "Quit/Exit")
            break
            ;;
        *) echo "Invalid option selected, $REPLY is a not a value.";;
    esac
done
