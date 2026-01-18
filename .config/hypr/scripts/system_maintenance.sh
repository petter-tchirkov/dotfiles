#!/bin/bash

echo "🛠 CachyOS Maintenance Menu"
echo "---------------------------"
echo "1) Update System"
echo "2) Clean System (cache, logs, orphans)"
echo "3) Check .pacnew/.pacsave configs"
echo "4) Exit"
echo

read -p "Choose an option [1-4]: " choice

case $choice in
    1)
        echo "🔄 Updating system and mirrors..."
        sudo rate-mirrors arch | sudo tee /etc/pacman.d/mirrorlist
        sudo pacman -Syyu
        yay -Syu
        ;;
    2)
        echo "🧹 Cleaning system..."
        sudo journalctl --vacuum-time=4weeks
        paccache -r
        paccache -ruk0
        yay -Yc
        ;;
    3)
        echo "📂 Checking .pacnew/.pacsave files..."
        DIFFPROG=meld pacdiff
        ;;
    4)
        echo "👋 Exiting..."
        exit 0
        ;;
    *)
        echo "❌ Invalid choice."
        ;;
esac
