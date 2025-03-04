#!/usr/bin/env bash

### Dev Box Setup ###
main() {
  ## Personal software ##

  sudo apt update
  sudo apt install --yes curl

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
  sudo apt install proton-vpn-gnome-desktop
  sudo apt install libayatana-appindicator3-1 gir1.2-ayatanaappindicator3-0.1 gnome-shell-extension-appindicator
  
  ## Dev software ##

  # Git
  say "Installing Git..."
  sudo apt install --yes git
  git config --global user.name "Bruno França"
  git config --global user.email "bruno@franca.xyz"

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

  # ZKsync Dev Setup
  zksync()

  # Clone repos
  say "Cloning ZKsync repositories..."
  mkdir -p "$HOME/Git"
  cd "$HOME/Git"
  git clone --recurse-submodules https://github.com/matter-labs/zksync-era.git
  git clone https://github.com/matter-labs/era-consensus.git
  git clone https://github.com/matter-labs/era-contracts.git
  git clone https://github.com/matter-labs/gitops-kubernetes.git

  # OhMyBash
  say "Installing OhMyBash..."
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

  say "Installation complete!"
}

### ZKsync Dev Setup ###
zksync() {
  # All necessary stuff
  say "Installing apt dependencies..."
  sudo apt update
  sudo apt install --yes apt-transport-https build-essential ca-certificates clang cmake libpq-dev libssl-dev lld lldb pkg-config software-properties-common

  # Rust
  say "Installing Rust..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y
  source "$HOME/.cargo/env"
  # SQL tools
  say "Installing SQLx CLI..."
  cargo install sqlx-cli --version 0.8.1
  # Cargo Nextest (for running unit tests)
  say "Installing Nextest..."
  cargo install cargo-nextest --locked
  # Cargo-deny (for era-consensus)
  say "Installing Cargo-deny..."
  cargo install cargo-deny --locked

  # Install Docker
  say "Installing Docker..."
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository --yes "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
  sudo apt install --yes docker-ce

  # Start Docker
  say "Starting Docker..."
  sudo systemctl start docker

  # NVM
  say "Installing NVM..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
  nvm install 20

  # Yarn
  say "Installing Yarn..."
  npm install -g yarn
  yarn set version 1.22.19

  # Foundry ZKsync
  say "Installing Foundry ZKsync..."
  curl -L https://raw.githubusercontent.com/matter-labs/foundry-zksync/main/install-foundry-zksync | bash

  # ZK Stack CLI
  say "Installing ZK Stack CLI..."
  curl -L https://raw.githubusercontent.com/matter-labs/zksync-era/main/zkstack_cli/zkstackup/install | bash
  "$HOME/.local/bin/zkstackup"

  # Non CUDA (GPU) setup, can be skipped if the machine has a CUDA installed for provers
  # Don't do that if you intend to run provers on your machine. Check the prover docs for a setup instead.
  say "Setting up the non-CUDA setup..."
  echo "export ZKSYNC_USE_CUDA_STUBS=true" >> "$HOME/.bashrc"
}

say() {
  echo -e "\033[1;32m$1\033[0m"
}

main "$@"

