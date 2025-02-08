#!/usr/bin/env bash

### Dev Box Setup ###
main() {
  # All necessary stuff
  say "Installing apt dependencies..."
  sudo apt update
  sudo apt install --yes git build-essential pkg-config cmake clang lldb lld libssl-dev libpq-dev apt-transport-https ca-certificates software-properties-common gh

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

  # Clone the repos
  say "Cloning ZKsync repositories..."
  git clone --recurse-submodules https://github.com/matter-labs/zksync-era.git
  git clone https://github.com/matter-labs/era-consensus.git
  git clone https://github.com/matter-labs/era-contracts.git

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

  # OhMyBash
  say "Installing OhMyBash..."
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

  say "Installation complete!"
}

say() {
  echo -e "\033[1;32m$1\033[0m"
}

main "$@"

