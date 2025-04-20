# Time_Skew_Fix

Fix time skew issues in Kerberos environments by syncing your system time with a Domain Controller using `systemd-timesyncd` and `ntpdate`.

This script is especially useful in penetration testing labs or Active Directory environments where Kerberos authentication fails due to clock drift (krb_ap_err_skew(clock skew too great)).

---

## 📦 Installation

### 1. 📝 Copy the script to `/usr/local/bin`

This is the standard location for custom system-wide scripts:

```bash
sudo cp Time_Skew_Fix.sh /usr/local/bin/Time_Skew_Fix.sh
```

### 2. ✅ Make it executable

```bash
sudo chmod +x /usr/local/bin/Time_Skew_Fix.sh
```

---

## 🚀 Usage

Run the script with the IP address of your Domain Controller:

```bash
sudo Time_Skew_Fix.sh <domain_controller_ip>
```

✅ Example:

```bash
sudo Time_Skew_Fix.sh 10.129.XX.XX
```

---

## ⚙️ What It Does

- Installs required time synchronization packages
- Enables and configures `systemd-timesyncd`
- Adds the Domain Controller as the NTP server
- Forces a manual sync using `ntpdate`
- Prints the time sync status

---

## 📄 Requirements

Make sure the following packages are installed:

- `systemd-timesyncd`
- `ntpdate`
- `util-linux`

(Optional) You can run the included `requirements.sh` script to install them automatically:

```bash
sudo ./requirements.sh
```

---

## 📜 License

MIT – use freely, modify openly, share proudly.
