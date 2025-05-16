#!/usr/bin/env bash

### Laptop Setup ###
main() {
  # Packages
  say "Installing packages..."
  sudo apt update
  sudo apt install --yes transmission libreoffice-calc libreoffice-writer libfuse2t64

   # Brave
  say "Installing Brave..."
  sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
  sudo apt update
  sudo apt install --yes brave-browser

  # Bing Wallpaper
  say "Installing Bing Wallpaper..."
  sudo apt install --yes gnome-shell-extension-manager

  # Installing Rclone
  say "Installing Rclone..."
  sudo apt install --yes unzip
  curl https://rclone.org/install.sh | sudo bash

  # Setup Rclone
  say "Setting up Rclone..."
  read -s -p "Proton password: " password
  echo
  rclone config create proton protondrive username=brunoffranca password=$(rclone obscure "$password")
  rclone sync proton:Thinkpad Proton # First sync here
  (crontab -l; echo "0 * * * * rclone sync Proton proton:Thinkpad") | crontab -
}

say() {
  echo -e "\033[1;32m$1\033[0m"
}

main "$@"
