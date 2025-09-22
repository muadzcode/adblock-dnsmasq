#!/bin/bash

BLOCKLIST="/etc/dnsmasq.d/blocklist.conf"
TMP_LIST="/tmp/blocklist.raw"

# Download multiple sources
curl -s https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts \
    https://adaway.org/hosts.txt \
    https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=0&mimetype=plaintext \
    https://raw.githubusercontent.com/Perflyst/PiHoleBlocklist/master/SmartTV-AGH.txt \
    https://raw.githubusercontent.com/Perflyst/PiHoleBlocklist/master/AmazonFireTV.txt \
    https://raw.githubusercontent.com/Perflyst/PiHoleBlocklist/master/SpotifyAds.txt \
    https://raw.githubusercontent.com/yous/YoutubeAdsBlocklist/master/domains.txt \
    | grep '^0.0.0.0' > "$TMP_LIST"

# Clean duplicates
sort -u "$TMP_LIST" > "$BLOCKLIST"

# Convert to dnsmasq format
awk '/^0.0.0.0/ {print "address=/" $2 "/0.0.0.0"}' "$BLOCKLIST" > /etc/dnsmasq.d/adblock.conf

# Restart dnsmasq
systemctl restart dnsmasq
