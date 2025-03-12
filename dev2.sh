#!/usr/bin/env bash

### ZKsync Dev Setup 2 ###
main() {
  # Start Docker
  say "Starting Docker..."
  sudo systemctl start docker

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

  # Clone repos
  say "Cloning ZKsync repositories..."
  mkdir -p "$HOME/Git"
  cd "$HOME/Git"
  git clone --recurse-submodules https://github.com/matter-labs/zksync-era.git
  git clone https://github.com/matter-labs/era-consensus.git
  git clone https://github.com/matter-labs/era-contracts.git

  say "Installation complete. Now reload your terminal to apply all changes."
}

say() {
  echo -e "\033[1;32m$1\033[0m"
}

main "$@"

