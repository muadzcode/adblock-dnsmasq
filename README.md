# Adblock with Dnsmasq

A lightweight ad-blocking solution using **dnsmasq**.  
This script automatically fetches and updates blocklists, converting them into a dnsmasq-compatible format to block ads, trackers, and unwanted domains at the DNS level.

---

## ✨ Features
- Uses `dnsmasq` to block ads system-wide
- Fetches blocklists from multiple sources
- Converts host-format lists into dnsmasq rules
- Simple update script (`update-adblock.sh`)
- Lightweight and runs on Linux without extra dependencies

---

## 📦 Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/YOUR_USERNAME/adblock-dnsmasq.git
   cd adblock-dnsmasq
