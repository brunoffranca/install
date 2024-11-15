#!/usr/bin/env bash

### Laptop Setup ###
main() {
  ## Personal software ##
  
  # Packages
  say "Installing packages..."
  sudo apt update
  sudo apt install --yes curl git transmission libreoffice

  # Brave
  say "Installing Brave..."
  sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
  sudo apt install --yes brave-browser

  # Spotify
  say "Installing Spotify..."
  curl -sS https://download.spotify.com/debian/pubkey_6224F9941A8AA6D1.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
  echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
  sudo apt install --yes spotify-client

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
  
  ## Dev software ##

  # Setup Git
  say "Setting up Git..."
  git config --global user.name "Bruno França"
  git config --global user.email "bruno@franca.xyz"

  # Dev packages
  say "Installing dev packages..."
  sudo apt update
  sudo apt install --yes gh build-essential libssl-dev gcloud

  # Rust
  say "Installing Rust..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y
  source "$HOME/.cargo/env"

  # VS Code
  say "Installing VS Code..."
  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
  sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
  echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
  rm -f packages.microsoft.gpg
  sudo apt install --yes code

  # OhMyBash
  say "Installing OhMyBash..."
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
}

say() {
  echo -e "\033[1;32m$1\033[0m"
}

main "$@"