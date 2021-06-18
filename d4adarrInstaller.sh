#! /bin/bash

echo "############ Starting d4adarrInstaller v1.0 ############"
echo "## Setting up local development area.. Please wait!"

echo "### Settings up Github development directories!"

echo "#### Making Github directory to store all files.."

cd home

mkdir Github

echo "Going into newly created folder"

cd Github

echo "Creating Github, Github_local and Experiments folders.."

mkdir Github && mkdir Github_local & mkdir Experiments

echo "Cloning Github and Experiments repositories inside Github folder.."

cd Github

echo "Cloning Saturn-startpage "
git clone https://github.com/mraif13/Saturn-startpage.git 


echo "Moving to github_local and creating a git.info file."

cd ..

cd Github_local

touch git.info

cd ..

echo "Creating Experiments and creating a experiments.info file!"

cd Experiments

touch Experiments.info

cd

echo "########## Installing APPS! ##########"

echo "Installing yay from Arch AUR.."

mkdir temp

cd temp

git clone https://aur.archlinux.org/yay.git

cd yay

makepkg -si

echo "Installing Visual Studio Code from AUR.. using yay!"

yay -S visual-studio-code-bin


echo "Installing ticktick.. using yay!"

yay -S ticktick-nativefier

cd 

cd temp

echo "Installing Pamac using Arch AUR.. "

git clone https://aur.archlinux.org/pamac-aur.git

cd pamac-aur 

makepkg -si

echo "Installing hakuneko-desktop.. using yay"

yay -S hakuneko-desktop

echo "Installing deezer using yay"

yay -S deezer

echo "Installing onlyoffice -bin version using yay"

yay -S onlyoffice-bin

echo "Installing Saturn Startpage chromium version.. from github using wget. (This might be slow due to some sort of connection downgrade on github side)"

wget https://github.com/mraif13/Saturn-startpage/archive/refs/heads/Chromium.zip

echo "#####################|All done!|#######################"

echo "Apps and Github folder is now setup.."

echo "|#|#|#|#|#|#|#|#|Killed by d4adarrInstaller|#|#|#|#|#|#|#|#|"
