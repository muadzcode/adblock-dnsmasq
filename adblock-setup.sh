#!/bin/bash
# adblock-setup.sh
# Simple ad-block setup using dnsmasq

# Make sure dnsmasq is installed
if ! command -v dnsmasq &> /dev/null; then
    echo "Installing dnsmasq..."
    sudo apt update && sudo apt install -y dnsmasq
fi

# Backup old config
sudo cp /etc/dnsmasq.conf /etc/dnsmasq.conf.backup

# Add blocking rules
sudo tee /etc/dnsmasq.d/adblock.conf > /dev/null <<EOL
# Block Spotify ads
address=/spclient.wg.spotify.com/0.0.0.0

# Block Crunchyroll ads
address=/static.crunchyroll.com/0.0.0.0

# Block YouTube ads (partial, rotates often)
address=/googleads.g.doubleclick.net/0.0.0.0
address=/pagead2.googlesyndication.com/0.0.0.0
EOL

# Restart dnsmasq
echo "Restarting dnsmasq..."
sudo systemctl restart dnsmasq

echo "✅ Ad-block setup complete!"
