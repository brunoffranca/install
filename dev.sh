#!/usr/bin/env bash

### Dev Box Setup ###
main() {
  ## Personal software ##

  # Packages
  say "Installing packages..."
  sudo apt update
  sudo apt install --yes build-essential libfuse2t64

  # Brave
  say "Installing Brave..."
  sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
  sudo apt update
  sudo apt install --yes brave-browser

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

  # Rust
  say "Installing Rust..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y
  source "$HOME/.cargo/env"
  # Cargo-nextest
  say "Installing cargo-nextest..."
  cargo install cargo-nextest --locked
  # Cargo-deny
  say "Installing cargo-deny..."
  cargo install cargo-deny --locked
  
  # OhMyBash
  say "Installing OhMyBash..."
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

  say "Now reload your terminal to apply all changes. And proceed to next script."
}

say() {
  echo -e "\033[1;32m$1\033[0m"
}

main "$@"

