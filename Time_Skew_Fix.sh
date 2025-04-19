#!/bin/bash
# fix-time-skew.sh
# Synchronize system time with a domain controller to fix time skew issues in Kerberos environments.
# Usage: sudo ./fix-time-skew.sh <domain_controller_ip>

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

echo "[*] Done. Final status:"
timedatectl status
timedatectl timesync-status

