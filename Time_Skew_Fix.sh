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

echo "[*] Configuring time sync with domain controller at $DC_IP..."

systemctl enable systemd-timesyncd
systemctl restart systemd-timesyncd

sed -i '/^NTP=/d' /etc/systemd/timesyncd.conf
echo "NTP=$DC_IP" >> /etc/systemd/timesyncd.conf

systemctl restart systemd-timesyncd
timedatectl set-ntp true

ntpdate -b "$DC_IP"

echo "[*] Done. Final status:"
timedatectl status
timedatectl timesync-status
