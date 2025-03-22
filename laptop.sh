#!/usr/bin/env bash

### Laptop Setup ###
main() {
  # Packages
  say "Installing packages..."
  sudo apt update
  sudo apt install --yes transmission libreoffice-calc libreoffice-writer

  # Installing Rclone
  say "Installing Rclone..."
  sudo apt install --yes unzip
  curl https://rclone.org/install.sh | sudo bash

  # Setup Rclone
  say "Setting up Rclone..."
  read -s -p "Proton password: " password
  echo
  rclone config create proton protondrive user=brunoffranca@protonmail.com pass=$(rclone obscure "$password")
  rclone sync proton:Thinkpad Proton # First sync here
  (crontab -l; echo "0 * * * * rclone sync Proton proton:Thinkpad") | crontab -

  # Brave
  say "Installing Brave..."
  sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
  sudo apt update
  sudo apt install --yes brave-browser

  # Spotify
  say "Installing Spotify..."
  curl -sS https://download.spotify.com/debian/pubkey_6224F9941A8AA6D1.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
  echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
  sudo apt update
  sudo apt install --yes spotify-client

  # Proton VPN
  say "Installing Proton VPN..."
  wget https://repo.protonvpn.com/debian/dists/stable/main/binary-all/protonvpn-stable-release_1.0.6_all.deb
  sudo dpkg -i ./protonvpn-stable-release_1.0.6_all.deb && sudo apt update
  sudo apt install --yes proton-vpn-gnome-desktop
  sudo apt install --yes libayatana-appindicator3-1 gir1.2-ayatanaappindicator3-0.1 gnome-shell-extension-appindicator

  # Bing Wallpaper
  say "Installing Bing Wallpaper..."
  sudo apt install --yes gnome-shell-extension-manager
}

say() {
  echo -e "\033[1;32m$1\033[0m"
}

main "$@"
