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
  # SQLx
  say "Installing SQLx CLI..."
  cargo install sqlx-cli --version 0.8.1
  # Cargo Nextest
  say "Installing Nextest..."
  cargo install cargo-nextest --locked
  # Cargo-deny (for era-consensus)
  say "Installing Cargo-deny..."
  cargo install cargo-deny --locked

  # Install Docker
  say "Installing Docker..."
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc
  echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update
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

