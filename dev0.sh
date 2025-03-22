#!/usr/bin/env bash

### Dev Box Setup 0 ###
main() {
  ## Personal software ##

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
  
  ## Dev software ##

  # Git
  say "Installing Git..."
  sudo apt install --yes git
  git config --global user.name "Bruno França"
  git config --global user.email "bruno@franca.xyz"

  # Github CLI
  say "Installing Github CLI..."
  sudo apt install --yes gh

  # Sublime Merge
  say "Installing Sublime Merge..."
  wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null
  echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
  sudo apt update
  sudo apt install --yes sublime-merge

  # gcloud CLI
  say "Installing gcloud CLI..."
  sudo apt install --yes apt-transport-https ca-certificates gnupg curl
  curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
  echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
  sudo apt update
  sudo apt install --yes google-cloud-cli

  # OhMyBash
  say "Installing OhMyBash..."
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

  say "Now reload your terminal to apply all changes. And proceed to next script."
}

say() {
  echo -e "\033[1;32m$1\033[0m"
}

main "$@"

