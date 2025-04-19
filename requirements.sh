#!/bin/bash
# requirements.sh
# Install required packages for time synchronization in Kerberos environments.

set -e

REQUIRED_TOOLS=("systemd-timesyncd" "ntpdate" "util-linux")

if [ "$EUID" -ne 0 ]; then
  echo "[!] Please run this script with sudo."
  exit 1
fi

echo "[*] Updating package list..."
apt update -y

echo "[*] Checking and installing required packages..."
for pkg in "${REQUIRED_TOOLS[@]}"; do
  if dpkg -s "$pkg" &> /dev/null; then
    echo "[-] $pkg is already installed."
  else
    echo "[+] Installing $pkg..."
    apt install -y "$pkg"
  fi
done

echo "[✓] All required packages are installed."
