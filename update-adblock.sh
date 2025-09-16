#!/bin/bash
# Auto AdBlock Updater for dnsmasq
# Covers Spotify + YouTube (extendable)

CONF_FILE="/etc/dnsmasq.d/adblock.conf"
TMP_FILE="/tmp/adblock.tmp"

echo "# Master AdBlock Config (Auto Updated: $(date))" > $TMP_FILE

# Spotify custom entries
cat <<EOL >> $TMP_FILE
# === Spotify ===
address=/ads.spotify.com/0.0.0.0
address=/adclick.g.doubleclick.net/0.0.0.0
address=/pubads.g.doubleclick.net/0.0.0.0
address=/partnerad.l.doubleclick.net/0.0.0.0
EOL

# YouTube custom entries
cat <<EOL >> $TMP_FILE
# === YouTube ===
address=/ads.youtube.com/0.0.0.0
address=/s.youtube.com/0.0.0.0
address=/s2.youtube.com/0.0.0.0
address=/pagead2.googlesyndication.com/0.0.0.0
address=/pubads.g.doubleclick.net/0.0.0.0
address=/googleads.g.doubleclick.net/0.0.0.0
EOL

# Add external blocklist (optional: StevenBlack hosts)
curl -s https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts | \
grep "^0.0.0.0" | awk '{print "address=/"$2"/0.0.0.0"}' >> $TMP_FILE

# Replace old config
sudo mv $TMP_FILE $CONF_FILE

# Restart dnsmasq
sudo systemctl restart dnsmasq

echo "AdBlock updated & dnsmasq restarted!"
