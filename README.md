🛡️ DNSMasq Ad Blocker

A lightweight ad-blocking setup for Linux using dnsmasq
.
This project redirects known ad domains (Spotify, Crunchyroll, YouTube, etc.) to 0.0.0.0, preventing them from loading.

🚀 Features

Blocks ads at the DNS level (system-wide).

Lightweight, no external software required.

Works for Spotify, Crunchyroll, YouTube (partial).

Can be extended with more ad domains.

📦 Requirements

Ubuntu / Debian (or derivatives).

dnsmasq package.

systemd (or service manager to run dnsmasq).

🔧 Installation

Clone the repo:

git clone https://github.com/muadzcode/adblock-dnsmasq.git
cd adblock-dnsmasq


Make the script executable:

chmod +x adblock-setup.sh


Run the setup:

./adblock-setup.sh

⚠️ Troubleshooting
1. dnsmasq fails to start (port 53 in use)

On modern Ubuntu, systemd-resolved may already be using port 53.

To fix:

sudo systemctl stop systemd-resolved
sudo systemctl disable systemd-resolved
sudo rm /etc/resolv.conf
echo "nameserver 127.0.0.1" | sudo tee /etc/resolv.conf
sudo systemctl restart dnsmasq

2. Test if blocking works

Check if an ad domain resolves to 0.0.0.0:

dig spclient.wg.spotify.com
dig static.crunchyroll.com
dig googleads.g.doubleclick.net


Expected output:

;; ANSWER SECTION:
spclient.wg.spotify.com.   0 IN A 0.0.0.0

📝 How It Works

dnsmasq acts as a local DNS resolver.

For normal domains → forwards queries to upstream DNS servers.

For ad domains → returns 0.0.0.0, making them unreachable.

🔮 Next Steps

Add more ad domains in /etc/dnsmasq.d/adblock.conf.

Automate updates with external blocklists.

Package as a .deb for easier installs.

🤝 Contributing

Pull requests welcome! Add more domains or improve automation.

📜 License

MIT License — free to use, modify, and share.
