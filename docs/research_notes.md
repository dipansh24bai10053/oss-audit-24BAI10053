# Firefox OSS Audit - Research Notes for Project Report

> Use these notes as reference when writing your report IN YOUR OWN WORDS.
> Do not copy-paste directly - rephrase everything.

---

## PART A: ORIGIN AND PHILOSOPHY (Units 1 & 2)

### A.1 The Birth of Firefox - Historical Timeline

**1994 - Netscape Navigator Born**
- Netscape Communications Corporation releases Netscape Navigator
- First commercial web browser, dominated the market with 90% share
- Founded by Marc Andreessen (creator of Mosaic) and Jim Clark

**1995-1997 - The Browser Wars**
- Microsoft launches Internet Explorer, bundles it with Windows
- IE gains market share rapidly due to Windows bundling
- Netscape's market share drops from 90% to under 50%

**1998 - The Historic Open Source Decision**
- January 22, 1998: Netscape announces source code will be free
- March 31, 1998: Source code released under Netscape Public License
- Mozilla Organization created to manage the open-source project
- This was one of the FIRST major commercial software to go open source
- Jamie Zawinski (jwz) was key engineer in this transition

**Why Did Netscape Open Source?**
1. Losing browser war to Microsoft's free IE
2. Hoped community development would accelerate innovation
3. Strategic move - if they couldn't win, at least deny Microsoft monopoly
4. Influenced by Eric Raymond's "The Cathedral and the Bazaar" essay

**2002 - Mozilla Foundation**
- AOL (which bought Netscape) creates Mozilla Foundation
- Non-profit organization to ensure project continues
- Mitchell Baker becomes chairwoman

**2004 - Firefox 1.0 Released**
- November 9, 2004: Firefox 1.0 launches
- Originally called "Phoenix" then "Firebird" then "Firefox"
- 100 million downloads in first year
- Broke IE's monopoly, peaked at 32% market share in 2009

### A.2 Mozilla Public License 2.0 (MPL-2.0) Analysis

**License Type:** Weak copyleft (file-level copyleft)

**Key Characteristics:**
| Aspect | MPL 2.0 | GPL | MIT |
|--------|---------|-----|-----|
| Copyleft | File-level | Strong (entire work) | None |
| Proprietary mixing | Allowed | Not allowed | Allowed |
| Patent grant | Yes | Yes (v3) | No |
| Commercial use | Yes | Yes | Yes |

**The Four Freedoms (applies to Firefox):**
1. Freedom to run the program for any purpose
2. Freedom to study how it works and modify it
3. Freedom to redistribute copies
4. Freedom to distribute modified versions

**MPL 2.0 Specific Terms:**
- Modified files must remain open source
- Can combine with proprietary code in larger work
- Must provide source code for MPL-licensed files
- Compatible with GPL and Apache licenses

**Why Mozilla Chose MPL:**
- Balance between open source ideals and practical adoption
- Encourages corporate contributions (less scary than GPL)
- Protects Firefox core while allowing ecosystem growth

### A.3 Philosophy and Values

**Mozilla Manifesto (10 Principles):**
1. Internet is a global public resource
2. Internet should remain open and accessible
3. Internet should enrich human lives
4. User security and privacy are fundamental
5. Individuals must shape the Internet
6. Open source is effective development method
7. Transparent community processes promote participation
8. Commercial involvement benefits open source
9. Mozilla's role is to promote these values
10. Magnifying public benefit aspects of Internet

**Key Quote:**
"Our mission is to ensure the Internet is a global public resource, open and accessible to all." - Mozilla

---

## PART B: LINUX FOOTPRINT (Unit 2)

### B.1 Firefox in Linux Ecosystem

**Default Browser in Many Distros:**
- Ubuntu (until 21.10, now Snap)
- Fedora
- Debian
- Linux Mint
- openSUSE

**Package Managers:**
```
Debian/Ubuntu: apt install firefox
Fedora: dnf install firefox
Arch: pacman -S firefox
openSUSE: zypper install firefox
```

**Firefox Dependencies on Linux:**
- GTK+ (GUI toolkit)
- glibc (C library)
- NSS (Network Security Services)
- NSPR (Netscape Portable Runtime)
- libpng, libjpeg, zlib

### B.2 Shell Scripting Concepts Used

**Script 1 - System Identity:**
- `uname -r` - kernel version
- `df -h` - disk usage
- `free -h` - memory info
- `/etc/os-release` - OS information

**Script 2 - FOSS Inspector:**
- `dpkg --get-selections` - list packages (Debian)
- `rpm -qa` - list packages (RHEL)
- `which` command - find executables

**Script 3 - Permissions:**
- `find -perm -0002` - world-writable files
- `find -perm -4000` - SUID files
- `stat -c "%a"` - show permissions

**Script 4 - Log Analysis:**
- `/var/log/syslog` - system logs
- `/var/log/auth.log` - authentication
- `journalctl` - systemd logs
- `grep -ci` - case-insensitive count

**Script 5 - Manifesto:**
- `read -p` - user input
- Heredoc (`<< EOF`) - multiline strings
- ANSI color codes for formatting

---

## PART C: FOSS ECOSYSTEM (Units 3 & 4)

### C.1 Mozilla Foundation Analysis

**Organization Type:** 501(c)(3) Non-profit

**Structure:**
```
Mozilla Foundation (non-profit)
    └── Mozilla Corporation (taxable subsidiary)
            └── Develops Firefox, Thunderbird, etc.
```

**Revenue Model:**
- Search engine deals (Google pays ~$400M/year for default search)
- Mozilla VPN subscriptions
- Donations
- Pocket Premium

**2022 Revenue:** ~$593 million (mostly from Google deal)

### C.2 Contribution Model

**Repository:** https://hg.mozilla.org/mozilla-central
- Uses Mercurial (hg), not Git
- Mirror on GitHub: https://github.com/nicklunt/nicklunt.github.io

**How to Contribute:**
1. Create Bugzilla account (bugzilla.mozilla.org)
2. Find "good first bug" issues
3. Set up build environment (mozilla-central)
4. Submit patch via Phabricator
5. Code review by Mozilla engineers
6. Land in mozilla-central

**Contributor Statistics (approximate):**
- 1000+ active contributors per year
- 20,000+ total historical contributors
- Commits per day: 50-100

**Communication Channels:**
- Matrix chat (chat.mozilla.org)
- Discourse forums
- Bugzilla for bug tracking
- Phabricator for code review

### C.3 Community and Governance

**Decision Making:**
- Module owners have final say on their components
- Mozilla leadership sets overall direction
- Community input through forums and RFC process

**Key Teams:**
- Firefox Desktop
- Firefox Mobile (Android)
- Platform/Gecko Engine
- Security
- Privacy
- Accessibility

---

## PART D: OPEN SOURCE VS PROPRIETARY COMPARISON

### Firefox vs Google Chrome

| Aspect | Firefox (Open Source) | Chrome (Proprietary*) |
|--------|----------------------|----------------------|
| **License** | MPL 2.0 | Proprietary (based on open-source Chromium) |
| **Source Code** | Fully open | Core open (Chromium), Google parts closed |
| **Organization** | Non-profit (Mozilla) | For-profit (Google/Alphabet) |
| **Revenue Model** | Search deals, donations | Advertising ecosystem |
| **Privacy** | Privacy-focused, blocks trackers | Collects user data for ads |
| **Tracking** | Enhanced Tracking Protection | Limited (conflicts with ad business) |
| **Data Collection** | Minimal, opt-in telemetry | Extensive, tied to Google account |
| **Extensions** | Open extension ecosystem | Manifest V3 limits ad blockers |
| **Engine** | Gecko (independent) | Blink (Google controlled) |
| **Market Share** | ~3% (2024) | ~65% (2024) |
| **Update Cycle** | Every 4 weeks | Every 4 weeks |
| **Mobile** | Android, iOS | Android, iOS |
| **Customization** | Highly customizable | Limited |
| **Memory Usage** | Generally lower | Higher |

### Why Open Source Matters Here

**Firefox Advantages:**
1. Code can be audited for security/privacy
2. No hidden tracking or backdoors
3. Community can fork if Mozilla fails
4. Independent from advertising companies
5. User interests prioritized over profits

**Chrome Concerns:**
1. Google's ad business conflicts with privacy
2. Manifest V3 weakens ad blockers
3. Monoculture risk (one engine dominates)
4. User data feeds advertising machine

### The Web Diversity Argument

- If only Chromium exists, Google controls web standards
- Firefox/Gecko provides alternative implementation
- Competition keeps innovation alive
- Mozilla advocates for user-centric web

---

## QUICK FACTS FOR YOUR REPORT

- Firefox first release: November 9, 2004
- Current version: 124.x (as of March 2024)
- Lines of code: ~25 million
- Languages: C++, Rust, JavaScript
- Rendering engine: Gecko
- JavaScript engine: SpiderMonkey
- Headquarters: San Francisco, CA
- Employees: ~750 (Mozilla Corp)
- Mascot: A red panda (not actually a fox!)

---

## USEFUL LINKS FOR CITATIONS

1. Mozilla Foundation: https://foundation.mozilla.org
2. MPL 2.0 Text: https://www.mozilla.org/MPL/2.0/
3. Mozilla Manifesto: https://www.mozilla.org/about/manifesto/
4. Firefox Source: https://hg.mozilla.org/mozilla-central
5. Contribution Guide: https://firefox-source-docs.mozilla.org/
6. Bugzilla: https://bugzilla.mozilla.org
7. Mozilla Blog: https://blog.mozilla.org
8. State of Mozilla Report: https://www.mozilla.org/foundation/annualreport/

---

*Remember: Write everything in YOUR OWN WORDS. These are just research notes!*
