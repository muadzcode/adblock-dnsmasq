#!/bin/bash
# adblock-setup.sh
# Setup dnsmasq-based ad blocker

set -e

# Make sure dnsmasq is installed
if ! command -v dnsmasq &> /dev/null; then
    echo "📦 Installing dnsmasq..."
    sudo apt update && sudo apt install -y dnsmasq
fi

# Make sure config folder exists
sudo mkdir -p /etc/dnsmasq.d

# Backup default config if it exists
if [ -f /etc/dnsmasq.conf ]; then
    sudo cp /etc/dnsmasq.conf /etc/dnsmasq.conf.backup
fi

# Add blocking rules
sudo tee /etc/dnsmasq.d/adblock.conf > /dev/null <<EOL
# Block Spotify ads
address=/spclient.wg.spotify.com/0.0.0.0

# Block Crunchyroll ads
address=/static.crunchyroll.com/0.0.0.0

# Block YouTube ads (partial)
address=/googleads.g.doubleclick.net/0.0.0.0
address=/pagead2.googlesyndication.com/0.0.0.0
EOL

# Restart dnsmasq
echo "🔄 Restarting dnsmasq..."
sudo systemctl restart dnsmasq || sudo service dnsmasq restart

echo "✅ Ad-block setup complete! Test with: dig spclient.wg.spotify.com"

