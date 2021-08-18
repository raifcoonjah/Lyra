#! /bin/bash


echo "Tabel installer v0.2 ALPHA"

echo " Let's start with a update.."

sudo pacman -Syu 

echo "> Setting up git.."
# echo "git init"
# git init
# echo "setting up git config"
# git config --global user.name "Raif Coonjah"
# git config --global user.email "raifcoonjah@pm.me"
# sudo git config --system core.editor nano
# git config --global credential.helper cache
# git config --global credential.helper 'cache --timeout=25000000000000'
# git config --global push.default simple

echo "Loading next step.."

echo "> Installing yay from AUR.."

git clone https://aur.archlinux.org/yay.git

echo "Clonning yay!"

echo "Makepkg -si"

cd yay

ls

makepkg -si

echo "Installed yay!"

echo "Creating local development directory now.."

clear

cd ..

mkdir Github

mkdir GithubLocal

mkdir Gitlab

echo "Cloning side project repos.."

cd Github

git clone https://github.com/mraif13/Saturn-startpage.git

git clone https://github.com/mraif13/mraif13.github.io

git clone https://github.com/mraif13/literallynothing.git

cd ..

cd Gitlab

echo "Cloning side project repos.. from gitlab"

git clone https://gitlab.com/saikouma/d4adinstaller.git

cd ..

echo "Creating VM Directory and download ISOs.."

mkdir VM

cd VM

echo "Downloading Manjaro Linux I3.."

wget https://download.manjaro.org/i3/21.0.7/manjaro-i3-21.0.7-210623-linux510.iso

echo "Debian: Downloading POP_OS! LTS"

wget https://pop-iso.sfo2.cdn.digitaloceanspaces.com/20.04/amd64/intel/30/pop-os_20.04_amd64_intel_30.iso

echo "Downloading windows 10 ISO.. OH SHIT I CANT :("
echo "Do it manually, because you know microsoft.."







