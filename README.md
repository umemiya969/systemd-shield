
![Platform](https://img.shields.io/badge/platform-linux-blue)
![Init](https://img.shields.io/badge/init-systemd-green)
![Shell](https://img.shields.io/badge/shell-bash-yellow)
![License](https://img.shields.io/github/license/umemiya969/systemd-shield)
![Last Commit](https://img.shields.io/github/last-commit/umemiya969/systemd-shield)

<p align="center">
  <img src="https://raw.githubusercontent.com/umemiya969/systemd-shield/main/assets/logo.svg" width="120">
</p>

<h1 align="center">systemd-shield</h1>

<p align="center">
  Make systemd feel like sysinit — safely, predictably, and reversibly.
</p>

<p align="center">
  <b>Boot faster · Fewer daemons · Zero breakage</b>
</p>

A **safe, profile-based systemd optimization framework** that makes systemd *feel* like a traditional sysinit (SysVinit/OpenRC) **without breaking modern Linux features**.

systemd-shield is **not** a random tweak script. It is a **behavior-shaping layer** for systemd, focused on:

* reducing idle overhead
* minimizing background daemons
* prioritizing on-demand activation
* keeping the system stable, reversible, and maintainable

---

## Why systemd-shield?

systemd-shield is not another systemd tweaker.

It is a **design-driven hardening layer** that reshapes systemd behavior to feel
like classic sysinit or OpenRC — **without disabling core services, breaking DNS,
or corrupting dependency graphs**.

---

## ✨ Key Features

* 🧠 **Sysinit-like mode** (minimal background services)
* 📉 Lightweight journald configuration (RAM-based)
* 🔌 Socket-first service activation
* 🧹 Target hygiene (cleaner dependency graph)
* ⚙️ Selective resource accounting
* 📦 Profile-based behavior presets
* ♻️ Safe & reversible design
* 🧩 Modular architecture

---

## 🎯 Design Philosophy

> systemd-shield does **not fight systemd**.
> It **teaches systemd to behave conservatively**.

What systemd-shield **does NOT do**:

* ❌ remove systemd
* ❌ mask critical units
* ❌ disable dbus / udev
* ❌ break dependency ordering

What systemd-shield **does**:

* ✔ reduce managerial overhead
* ✔ defer service startup until needed
* ✔ minimize logging cost
* ✔ keep the system debuggable

---

## 📁 Project Structure

```text
systemd-shield/
├── cli.sh                  # User entry point
├── core/                   # Orchestration layer
│   ├── loader.sh
│   ├── safety.sh
│   ├── logger.sh
│   └── rollback.sh
├── modules/                # Single-responsibility tweaks
│   ├── journald_guard.sh
│   ├── socket_first.sh
│   ├── target_hygiene.sh
│   ├── service_guard.sh
│   └── resource_guard.sh
├── detect/                 # Environment detection (context-aware)
├── profiles/               # Behavior presets (data only)
│   ├── desktop.conf
│   ├── lowend.conf
│   └── sysinit-like.conf
├── VERSION
├── CHANGELOG.md
└── README.md
```

---

## 🚀 Installation

Clone the repository:

```bash
git clone https://github.com/umemiya969/systemd-shield.git
cd systemd-shield
```

Make scripts executable:

```bash
chmod +x cli.sh modules/*.sh core/*.sh
```

---

## ▶️ Usage

### Apply a profile

```bash
sudo ./cli.sh apply sysinit-like
```

Available profiles:

* `desktop`
* `lowend`
* `sysinit-like`

### Show status

```bash
./cli.sh status
```

### Rollback (basic)

```bash
sudo ./cli.sh rollback
```

---

## 🧠 sysinit-like Profile Explained

The **sysinit-like** profile makes systemd behave closer to classic init systems:

* minimal always-on daemons
* services start only when needed
* lightweight logging
* reduced accounting overhead

### What changes:

| Area                | Default systemd         | sysinit-like          |
| ------------------- | ----------------------- | --------------------- |
| Journald            | Persistent & compressed | Volatile (RAM)        |
| Services            | Eager start             | On-demand             |
| Socket activation   | Partial                 | Prioritized           |
| Resource accounting | Global                  | Selective             |
| Timers              | Many enabled            | Non-critical disabled |

---

## 🛡 Safety Guarantees

systemd-shield is designed to be **safe by default**:

* All changes use **drop-in configs**
* No vendor files are modified
* No critical units are masked
* Rollback path is planned and explicit

If something goes wrong, you can always boot with the previous configuration.

---

## 🧪 Tested On

* Arch Linux
* Fedora
* Debian / Ubuntu (systemd-based)

> Other systemd distributions should work, but are not officially tested.

---

## ⚠️ Disclaimer

This project modifies systemd behavior.
While it is designed to be safe, **use at your own risk**.

Always read profiles before applying them.

---

## 📜 License

MIT License

---

## 🤝 Contributing

Contributions are welcome.

Guidelines:

* Keep modules single-responsibility
* Do not hardcode distro-specific hacks
* Prefer drop-in configs over masking
* Follow DESIGN.md principles

---

## 🌟 Why systemd-shield?

Because modern Linux does not need to be heavy.

systemd-shield proves that:

> **You can have modern systemd AND sysinit-like simplicity.**
