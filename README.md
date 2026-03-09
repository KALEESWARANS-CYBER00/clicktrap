# CLICKTRAP | Cybersecurity Awareness Exhibit

![ClickTrap Hero](assets/hero.png)

> "In the modern digital landscape, the most sophisticated firewall is rendered obsolete by a single, instinctual movement: the double-click."

## Overview

**ClickTrap** is a living documentary of human fallibility in the digital age. It is a cybersecurity awareness project designed to demonstrate the "Cognitive Gap"—the split-second between curiosity and consequence where security protocols are often abandoned for the promise of a visual narrative.

This tool meticulously deconstructs the **Visual Deception** lifecycle, weaponizing the familiarity of a harmless photograph to reveal how attackers leverage emotional hooks and social context to bypass critical thinking.

---

## Anatomy of the Attack

The "ClickTrap" methodology is a subset of the **Trojanized File Architecture**. It focuses on bypassing the technical via the psychological through a three-stage process:

### 1. Skinning the Payload
The attacker masks the execution bit behind a familiar facade (e.g., a `.desktop` entry on Linux). By utilizing MIME-type manipulation and curated iconography, a high-level Python script is "skinned" as a standard image asset.

### 2. The False Environment
Upon execution, a **Dual-Action Chain** is initiated. A decoy image is opened to maintain the illusion of legitimacy, while the awareness payload initializes silently in the background.

### 3. The Cognitive Mirror
Instead of exfiltrating data, ClickTrap provides immediate forensic feedback. The user is met with a high-impact visual briefing that mirrors their own actions back to them, providing a permanent lesson in digital hygiene.

---

## Architecture of Deceit

- **The Chameleon Protocol**: Advanced file disguising using Linux Desktop Entry (XDG) specifications.
- **Immediate Feedback Loop**: A sophisticated educational briefing that replaces malicious payloads.
- **Low-Level Orchestration**: Native shell scripting and Python-driven logic for seamless environment integration.
- **MIME Masking**: Overriding icon and mime-type associations to maintain the visual ruse.

---

## Operative Manual

### Prerequisites
- **Python 3.x**
- **Tkinter** (Standard on most Linux distributions: `sudo apt install python3-tk`)
- **Linux Environment** (Optimized for Ubuntu/Debian/Fedora)

### Installation
Deploy the tool in a secure, isolated research environment:

```bash
# Acquire the source
git clone https://github.com/KALEESWARANS-CYBER00/clicktrap.git

# Enter the research directory
cd clicktrap

# Elevate permissions and initiate the bind
chmod +x install.sh
./install.sh
```

### Observation
1. After installation, a **Holiday Photo** asset will materialize on your workspace.
2. Trigger the interaction by double-clicking the asset.
3. Observe the simultaneous launch of the decoy image and the awareness briefing.

---

## Core Modules

- `awareness.py`: The payload. A full-screen overlay providing the social engineering briefing.
- `clicktrap.py`: The orchestrator. Manages the dual-execution flow between decoy and payload.
- `install.sh`: The delivery mechanism. Automates the creation of the XDG entry.

---

## Author

**KALEESWARAN S**
*Ethical Hacker • Red Team Operator • CTF Strategist*

Focused on the convergence of technical offensive security and human behavioral patterns. ClickTrap is part of a broader research initiative into **Curiosity as a Vector**.

---

## License

This project is licensed under the [MIT License](LICENSE). 
*FOR EDUCATIONAL PURPOSES ONLY. Unauthorized use for malicious activities is strictly prohibited.*
