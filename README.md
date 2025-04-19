# Time_Skew_Fix
### Description
Fix time skew issues in Kerberos environments by syncing system time with a domain controller using systemd-timesyncd and ntpdate.

### 1. 📝 Save the script to `/usr/local/bin` And Paste the code

This is the standard place for custom system-wide scripts.

```bash

sudo nano /usr/local/bin/Time_Skew_Fix.sh

```

### 2. ✅ Make it executable

```bash

sudo chmod +x /usr/local/bin/Time_Skew_Fix.sh

```

---

### 3. 🚀 Use it like a command

```bash

sudo Time_Skew_Fix.sh 10.129.XX.XX

```

And with this time skew problems should be gone.

---
