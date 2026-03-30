# Firefox Open Source Audit

A comprehensive shell scripting project that audits and analyzes the open-source ecosystem surrounding Mozilla Firefox and the Linux environment.

## Project Overview

This project is developed as part of the Open Source Software (OSS) capstone project. It consists of 5 shell scripts that help users understand their Linux system, inspect FOSS packages, audit security permissions, analyze logs, and generate a personal open-source manifesto.

**Software Audited:** Mozilla Firefox
**License:** Mozilla Public License 2.0 (MPL-2.0)
**Developer:** Mozilla Foundation

## Why Firefox?

Firefox was chosen for this audit because:

- **Pioneer of Open Source Browsers:** Born from Netscape's decision to open-source their code in 1998
- **Non-profit Backing:** Maintained by Mozilla Foundation, a non-profit dedicated to internet health
- **MPL License:** Uses a balanced open-source license that allows proprietary use while keeping modifications open
- **Community Driven:** Thousands of contributors worldwide
- **Privacy Focused:** Built with user privacy as a core principle

## Scripts Included

### 1. System Identity Report (`system_identity.sh`)
Collects and displays comprehensive system information including:
- Operating system details and kernel version
- Network configuration
- Disk usage statistics
- Memory information
- User details

**Usage:**
```bash
chmod +x scripts/system_identity.sh
./scripts/system_identity.sh
```

### 2. FOSS Package Inspector (`foss_inspector.sh`)
Analyzes installed packages on the system:
- Detects package manager (apt, dnf, pacman, yum)
- Checks if Firefox is installed
- Lists common FOSS packages
- Provides FOSS percentage estimate

**Usage:**
```bash
chmod +x scripts/foss_inspector.sh
./scripts/foss_inspector.sh
```

### 3. Disk and Permission Auditor (`disk_permission_auditor.sh`)
Audits file system security:
- Disk usage per partition
- World-writable file detection
- SUID/SGID binary identification
- Critical file permission verification

**Usage:**
```bash
chmod +x scripts/disk_permission_auditor.sh
./scripts/disk_permission_auditor.sh
# Some checks may require sudo
```

### 4. Log File Analyzer (`log_analyzer.sh`)
Parses and analyzes system logs:
- Counts errors, warnings, and info messages
- Shows recent error and warning entries
- Analyzes authentication logs
- Supports journalctl on systemd systems

**Usage:**
```bash
chmod +x scripts/log_analyzer.sh
./scripts/log_analyzer.sh
# Requires sudo for full log access
```

### 5. Open Source Manifesto Generator (`manifesto_generator.sh`)
Interactive script that creates a personalized FOSS manifesto:
- Collects user's views on open source
- Generates formatted manifesto document
- Saves output to text file

**Usage:**
```bash
chmod +x scripts/manifesto_generator.sh
./scripts/manifesto_generator.sh
```

## Requirements

- Linux-based operating system (Ubuntu, Debian, Fedora, Arch, etc.)
- Bash shell (version 4.0 or higher)
- Standard GNU utilities (grep, awk, sed, find, df, etc.)

## Quick Start

1. Clone the repository:
```bash
git clone https://github.com/YOUR_USERNAME/firefox-oss-audit.git
cd firefox-oss-audit
```

2. Make all scripts executable:
```bash
chmod +x scripts/*.sh
```

3. Run any script:
```bash
./scripts/system_identity.sh
```

## Project Structure

```
firefox-oss-audit/
├── README.md
├── .gitignore
├── scripts/
│   ├── system_identity.sh
│   ├── foss_inspector.sh
│   ├── disk_permission_auditor.sh
│   ├── log_analyzer.sh
│   └── manifesto_generator.sh
└── docs/
    ├── research_notes.md          # Research material for report
    ├── REPORT_TEMPLATE.md         # Report writing template
    ├── output_script1_*.txt       # Sample outputs
    ├── output_script2_*.txt
    ├── output_script3_*.txt
    ├── output_script4_*.txt
    └── output_script5_*.txt
```

## Documentation

The `docs/` folder contains:
- **research_notes.md** - Comprehensive research on Firefox history, MPL license, and Mozilla Foundation
- **REPORT_TEMPLATE.md** - Template with all required sections for the project report
- **output_script*.txt** - Sample outputs from running scripts on Ubuntu 24.04 LTS

## Sample Output

### System Identity Report
```
*********************************************
*       SYSTEM IDENTITY REPORT              *
*       Firefox OSS Audit Project           *
*********************************************

======================================
  OPERATING SYSTEM INFO
======================================
OS Name             : Ubuntu 22.04.3 LTS
Kernel Version      : 5.15.0-91-generic
Architecture        : x86_64
Shell               : /bin/bash
```

### FOSS Package Inspector
```
[+] Package Manager: apt (Debian/Ubuntu)
[+] Firefox is INSTALLED on this system
    Version: Mozilla Firefox 121.0

[+] git - Installed
[+] python3 - Installed
[+] vim - Installed
```

## Learning Outcomes

Through this project, I learned:

1. **Shell Scripting:** Advanced bash scripting including functions, conditionals, and loops
2. **Linux Administration:** System commands for gathering system information
3. **Security Awareness:** Understanding file permissions and SUID/SGID implications
4. **Log Analysis:** Parsing and interpreting system logs
5. **Open Source Philosophy:** The values and principles behind FOSS movement

## References

- [Mozilla Firefox Official Website](https://www.mozilla.org/firefox/)
- [Mozilla Public License 2.0](https://www.mozilla.org/MPL/2.0/)
- [GNU Bash Manual](https://www.gnu.org/software/bash/manual/)
- [Linux man pages](https://man7.org/linux/man-pages/)
- [Free Software Foundation](https://www.fsf.org/)

## Author

**Dipansh Bareja**
Registration Number: 24BAI10053
B.Tech CSE (AI & ML) - 2nd Year
VIT Bhopal University

## License

This project is open source and available under the MIT License.

---

*This project was developed as part of the Open Source Software course capstone project.*
