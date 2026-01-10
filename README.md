# 🛡️ systemd-shield

**Adaptive systemd optimizer & guard for Linux**

> Mitigates common systemd weaknesses in a **safe**, **adaptive**, and **reversible** way  
without kernel patching, aggressive tweaks, or breaking your system.

---

## ✨ What is systemd-shield?

`systemd-shield` is a systemd optimization tool written in shell script that:

- Automatically detects system conditions
- Reduces excessive disk & IO usage from logging
- Prevents desktop freezes caused by memory pressure
- Disables unnecessary services safely
- Always provides **backup and rollback**

Designed for:
- Daily Linux desktops
- Low-end laptops
- Workstations
- Power users on systemd-based distributions

---

## 🎯 systemd Problems Addressed

| Problem | Solution |
|-------|----------|
| Journald excessive disk & IO usage | Journald Guard |
| System freeze under memory pressure | systemd-oomd Guard |
| Unused background services | Smart Service Guard |
| Long default boot timeouts | Boot Guard |
| Inconsistent resource accounting | Resource Guard |

---

## 🧠 How It Works

```
Detect system
   ↓
Analyze hardware & environment
   ↓
Apply safe systemd guards
   ↓
Restart affected systemd components
```

✔ No systemd binary patching  
✔ No kernel modifications  
✔ No dangerous sysctl tweaks  

---

## 🔍 Automatic Detection

systemd-shield automatically detects:

- RAM size (low / mid / high)
- CPU core count
- HDD or SSD
- Desktop vs server environment
- Network stack (NetworkManager / networkd)
- Bluetooth usage
- Printer usage (CUPS)

The tool **never guesses** — all actions are based on real system state.

---

## ⚙️ Key Features

### 🧾 Journald Guard
- Log size limits
- Compression enabled
- Reduced disk write amplification

### 🧠 OOMD Guard
- Memory pressure tuning
- Prevents total system freeze
- Desktop-friendly behavior

### 🧮 Resource Guard
- Enables CPU, memory, and task accounting
- Improves system stability and control

### 🚀 Boot Guard
- Shorter systemd timeouts
- Faster boot without added risk

### 🔌 Smart Service Guard
- Disables Bluetooth if unused
- Disables CUPS when no printer is present

---

## 📁 Project Structure

```
systemd-shield/
├── systemd-shield.sh
├── detect/
│   ├── hardware.sh
│   ├── environment.sh
│   └── services.sh
├── modules/
│   ├── journald_guard.sh
│   ├── oomd_guard.sh
│   ├── resource_guard.sh
│   ├── boot_guard.sh
│   ├── service_guard.sh
│   └── rollback.sh
```

---

## 🚀 Installation & Usage

```bash
git clone https://github.com/USERNAME/systemd-shield.git
cd systemd-shield
chmod +x systemd-shield.sh
sudo ./systemd-shield.sh
```

---

## 🔄 Rollback

All configuration files are automatically backed up to:

```
/etc/systemd-shield-backup/
```

Manual rollback:

```bash
source modules/rollback.sh
rollback
```

---

## 🛡️ Safety & Philosophy

- ❌ No systemd patching
- ❌ No kernel modifications
- ❌ No critical service removal
- ❌ No aggressive tuning

**Primary focus:** stability, responsiveness, and safety.

---

## 📦 Supported Distributions

- Arch Linux
- Fedora
- Ubuntu
- Debian
- openSUSE

> Any **systemd-based** Linux distribution

---

## ❗ Disclaimer

- Not a replacement for advanced manual tuning
- Not recommended for critical production servers without testing
- Use with basic systemd knowledge

---

## 🛣️ Roadmap

- [ ] CLI flags (`--dry-run`, `--rollback`)
- [ ] Preset profiles (desktop / gaming / lowend)
- [ ] System health report (daily summary)
- [ ] GUI frontend (optional)
- [ ] Packaging (AUR / COPR / DEB)

---

## 📜 License

MIT License  
Free to use, modify, and distribute.

---

## ⭐ Why systemd-shield?

Because it is:
- Not a random tweak script
- Based on real system detection
- Safe and reversible
- Built with a **product mindset**, not experimentation
