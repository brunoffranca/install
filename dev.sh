### ZK Sync Dev Setup ###

# Clone other repos
git clone https://github.com/matter-labs/era-consensus.git
git clone https://github.com/matter-labs/era-contracts.git

# Cargo-deny
cargo install cargo-deny --locked

### Bruno's Dev Setup ###

# Github
sudo apt install gh

# VS Code
sudo apt install --yes wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg
sudo apt update
sudo apt install --yes code

# OhMyBash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
