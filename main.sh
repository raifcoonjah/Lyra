#!/bin/bash
echo "
    ___       ___       ___       ___   
   /\  \     /\  \     /\  \     /\  \     /\__\  
   \:\  \   /::\  \   /::\  \   /::\  \   /:/  /  
   /::\__\ /::\:\__\ /::\:\__\ /::\:\__\ /:/__/   
  /:/\/__/ \/\::/  / \:\::/  / \:\:\/  / \:\  \   
  \/__/      /:/  /   \::/  /   \:\/  /   \:\__\  
             \/__/     \/__/     \/__/     \/__/

            ++ Version: 1.0 ++
    Developed & Maintain by Tabel Developers.
"

echo "Please choose your distro: "


supported_distros=("Arch Linux" "Debian/Ubuntu" "Fedora" "Quit/Exit")
select opt in "${supported_distros[@]}"
do
    case $opt in
        "Arch Linux")
            echo "Selected Arch Linux.."
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