![Platform](https://img.shields.io/badge/platform-linux-blue)
![Init](https://img.shields.io/badge/init-systemd-green)
![Shell](https://img.shields.io/badge/shell-bash-yellow)
![License](https://img.shields.io/github/license/umemiya969/systemd-shield)
![Release](https://img.shields.io/github/v/release/umemiya969/systemd-shield)
![Last Commit](https://img.shields.io/github/last-commit/umemiya969/systemd-shield)

<p align="center">
  <img src="https://raw.githubusercontent.com/umemiya969/systemd-shield/main/logo2.png" width="120">
</p>

<h1 align="center">systemd-shield</h1>

<p align="center">
  Make systemd feel like sysinit — safely, predictably, and reversibly.
</p>

<p align="center">
  <b>Boot faster · Fewer daemons · Zero breakage</b>
</p>


---

## What is systemd-shield?

**systemd-shield** is a design-driven hardening and optimization layer for
systemd-based Linux systems.

It reshapes systemd to behave more like classic **sysinit/OpenRC** — minimal,
predictable, and on-demand — **without disabling core services, breaking DNS,
or corrupting systemd’s dependency graph**.

This project focuses on **engineering discipline**, not ideology.

---

## Why systemd-shield?

Most “systemd debloat” scripts:

* break DNS resolution
* break networking
* mask critical services
* leave systems unrecoverable

systemd-shield takes a different approach:

* safety-first design
* fully reversible changes
* no vendor unit modification
* no removal of systemd components

If a change is not safe, it does not belong here.

---

## Core Features

* 🛡 **Service Guard** — safely disable non-critical background services
* 🔌 **Socket-First Activation** — start services only when needed
* 🧹 **Target Hygiene** — clean unnecessary target overrides
* 🌐 **DNS-Safe Modes** — systemd-resolved, NetworkManager, or static DNS
* ♻️ **Reversible by Design** — no permanent system damage

---

## Stability

systemd-shield **v1.0.0** is considered **stable**.

All modules are:

* idempotent
* reversible
* safe to re-run

Breaking changes will only be introduced in major versions.

---

## Quick Start

```bash
git clone https://github.com/umemiya969/systemd-shield.git
cd systemd-shield
sudo ./cli.sh apply sysinit-like
```

> Always review profiles before applying changes.

---

## Safety Guarantees

systemd-shield guarantees:

* DNS will always remain functional
* Networking will not be disabled
* Core system services are protected
* Vendor unit files are never modified

If the system becomes unstable, it is considered a bug.

---

## Roadmap

See [ROADMAP.md](ROADMAP.md) for upcoming features, including:

* preflight system checks
* automatic rollback
* dry-run mode
* benchmarking tools

---

## Design

For architectural details and design philosophy, see:
[DESIGN.md](DESIGN.md)

---

## Security

Please see [SECURITY.md](SECURITY.md) for vulnerability reporting.

---

## License

This project is licensed under the **MIT License**.
