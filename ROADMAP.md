# systemd-shield Roadmap

This roadmap outlines the planned evolution of **systemd-shield** after the
v1.0.0 stable release.

The focus is on **safety, observability, and predictability**, not feature
bloat.

---

## v1.1.0 — Safety & Observability (Next)

**Theme:** _Trust before tuning_

### Planned Features

#### 1. Preflight System Checks
Before applying any profile, systemd-shield will verify:
- DNS resolution is functional
- Network interfaces are up
- Default target is reachable
- systemctl is operational

If a critical check fails, the apply process will abort safely.

---

#### 2. Automatic Rollback on Failure
If system integrity is compromised:
- previous service enable states will be restored
- DNS configuration will be reverted
- systemd daemon-reload will be re-applied

Rollback will be:
- automatic
- atomic
- logged

---

#### 3. Global Dry-Run Mode
A `--dry-run` option will:
- show what services, sockets, timers, and targets will change
- perform no destructive actions
- help users audit profiles before applying

---

#### 4. Execution Logging
Introduce structured logs:
- timestamped actions
- module-level reporting
- success / skip / failure indicators

Logs will help debugging and issue reporting.

---

## v1.2.0 — Profiles & Benchmarks

**Theme:** _Measure, then optimize_

### Planned Features
- Built-in `systemd-analyze` before/after benchmarking
- New profile: `server-minimal`
- Profile validation tooling
- Profile diff viewer

---

## v2.0.0 — Maturity

**Theme:** _Production-grade system tuning_

### Long-Term Goals
- Interactive TUI mode
- Policy-based configuration
- Distribution-specific profiles
- Security hardening presets

---

## Design Principles (Non-Negotiable)

- No irreversible changes
- No vendor unit modification
- No network or DNS breakage
- No forced ideology

If a feature violates these principles, it will not be merged.

---

## Community Involvement

Feature requests and design discussions are welcome via:
- GitHub Issues
- GitHub Discussions

Large changes require design discussion before implementation.
