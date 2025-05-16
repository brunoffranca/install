# Laptop
Run this command:

curl https://raw.githubusercontent.com/brunoffranca/install/main/laptop.sh | bash

Then:
1. Setup unlocking gnome-keyring with LUKS password (https://gist.github.com/Majlo34/cbf059003ae91e1e49e9b00db7342628).
2. Install Bing Wallpaper on GNOME extensions.
3. Install Spotify (https://www.spotify.com/de-en/download/linux/).
4. Install Proton VPN (https://protonvpn.com/support/official-linux-vpn-ubuntu).
5. Add Proton VPN to autostart applications (protonvpn-app).
6. Setup sync on Brave.

# Dev machine
Run these commands sequentially and follow instructions at the end of each one:

curl https://raw.githubusercontent.com/brunoffranca/install/main/dev0.sh | bash

curl https://raw.githubusercontent.com/brunoffranca/install/main/dev1.sh | bash

curl https://raw.githubusercontent.com/brunoffranca/install/main/dev2.sh | bash

Then:
1. Everything in Laptop (except the script).
2. Install Cursor (https://github.com/jorcelinojunior/cursor-setup-wizard and config in my gists) 
3. Log into Github CLI with "gh auth login".
4. Setup Google cloud with "gcloud init".

# Node
Run this command:

curl https://raw.githubusercontent.com/brunoffranca/install/main/node.sh | bash
