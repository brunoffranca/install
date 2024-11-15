#!/usr/bin/env bash

### Dev Box Setup ###
main() {
  # ZKsync Dev Setup
  curl -L https://raw.githubusercontent.com/matter-labs/zksync-era/main/docs/src/guides/setup-dev.sh | bash

  # Cargo-deny (for era-consensus)
  say "Installing Cargo-deny..."
  cargo install cargo-deny --locked

  # Clone more repos
  say "Cloning more ZKsync repositories..."
  git clone https://github.com/matter-labs/era-consensus.git
  git clone https://github.com/matter-labs/era-contracts.git

  # Github CLI
  say "Installing Github CLI..."
  sudo apt install --yes gh

  # Setup Git
  say "Setting up Git..."
  git config --global user.name "Bruno França"
  git config --global user.email "bruno@franca.xyz"

  # VS Code
  say "Installing VS Code..."
  sudo apt install --yes wget gpg
  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
  sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
  echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
  rm -f packages.microsoft.gpg
  sudo apt update
  sudo apt install --yes code
}

say() {
  echo -e "\033[1;32m$1\033[0m"
}

main "$@"

