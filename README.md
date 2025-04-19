# CathorX.github.ci
### 1. 📝 Save the script to `/usr/local/bin`

This is the standard place for custom system-wide scripts.

```bash

sudo nano /usr/local/bin/fix-time-skew

```

### Paste this code

```bash
#!/bin/bash

# Usage: sudo fix-time-skew <dc_ip>
# Example: sudo fix-time-skew 10.129.XX.XX

if [ "$EUID" -ne 0 ]; then
  echo "[!] Run this script with sudo"
  exit 1
fi

if [ -z "$1" ]; then
  echo "[!] Usage: $0 <domain_controller_ip>"
  exit 1
fi

DC_IP="$1"

echo "[*] Installing required packages..."
apt update -y
apt install -y systemd-timesyncd ntpdate util-linux

echo "[*] Enabling systemd-timesyncd..."
systemctl enable systemd-timesyncd
systemctl restart systemd-timesyncd

echo "[*] Configuring /etc/systemd/timesyncd.conf with DC IP $DC_IP..."
sed -i '/^NTP=/d' /etc/systemd/timesyncd.conf
echo "NTP=$DC_IP" >> /etc/systemd/timesyncd.conf

echo "[*] Restarting systemd-timesyncd with new config..."
systemctl restart systemd-timesyncd
timedatectl set-ntp true

echo "[*] Forcing manual sync with ntpdate..."
ntpdate -b "$DC_IP"
#Try to install it (optional) 
#echo "[*] Syncing hardware clock to system time..."
#hwclock --systohc

echo "[*] Done. Final status:"
timedatectl status
timedatectl timesync-status

```

---

### 2. ✅ Make it executable

```bash

sudo chmod +x /usr/local/bin/fix-time-skew

```

---

### 3. 🚀 Use it like a command

```bash

sudo fix-time-skew 10.129.XX.XX

```

And with this time skew problems should be gone.

---
