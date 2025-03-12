#!/usr/bin/env bash

### ZKsync Dev Setup 1 ###
main() {
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
  sudo usermod -aG docker ${USER}

  # NVM
  say "Installing NVM..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
  nvm install 20

  say "Now logout and login again to apply all changes. And proceed to next script."
}

say() {
  echo -e "\033[1;32m$1\033[0m"
}

main "$@"

