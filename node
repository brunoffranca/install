#!/usr/bin/env bash

### ZKsync External Node Setup ###
main() {
  # All necessary stuff
  say "Installing apt dependencies..."
  sudo apt update
  sudo apt install --yes git software-properties-common

  # Install Docker
  say "Installing Docker..."
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository --yes "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
  sudo apt install --yes docker-ce

  # Clone the repo
  say "Cloning ZKsync repository..."
  git clone https://github.com/matter-labs/zksync-era.git
}

main "$@"
