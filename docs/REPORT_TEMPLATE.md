# PROJECT REPORT TEMPLATE
## Firefox Open Source Audit
### Open Source Software (OSS) Course - Capstone Project

---

**Student Name:** Dipansh Bareja
**Registration Number:** [YOUR REG NUMBER]
**Course:** B.Tech CSE (AI & ML) - 2nd Year
**Date:** March 2026

---

## TABLE OF CONTENTS

1. Introduction
2. Part A: Origin and Philosophy
   - 2.1 History of Firefox
   - 2.2 License Analysis (MPL 2.0)
   - 2.3 Philosophy and Values
3. Part B: Linux Footprint
   - 3.1 Firefox in Linux Ecosystem
   - 3.2 Shell Scripts Overview
   - 3.3 Script Outputs and Analysis
4. Part C: FOSS Ecosystem
   - 4.1 Mozilla Foundation
   - 4.2 Contribution Model
   - 4.3 Community and Governance
5. Part D: Open Source vs Proprietary
   - 5.1 Firefox vs Chrome Comparison
   - 5.2 Analysis and Recommendations
6. Conclusion
7. References
8. Appendix: Script Source Code

---

## 1. INTRODUCTION

[Write 150-200 words introducing:]
- What is open source software?
- Why did you choose Firefox for this audit?
- What are the objectives of this project?
- Brief overview of what the report covers

**Sample opening (rephrase in your words):**
"This report presents a comprehensive audit of Mozilla Firefox, one of the most
significant open-source web browsers in computing history. As a student of
Computer Science with a focus on AI and ML, understanding open source software
is crucial because..."

---

## 2. PART A: ORIGIN AND PHILOSOPHY

### 2.1 History of Firefox

[Write about the timeline - use the research notes but put it in YOUR words]

Key points to cover:
- 1994: Netscape Navigator created
- Browser wars with Microsoft
- 1998: Netscape open-sources code (historic decision)
- 2002: Mozilla Foundation formed
- 2004: Firefox 1.0 released
- Present day: Firefox's current state

**Include a timeline diagram if possible**

### 2.2 License Analysis: Mozilla Public License 2.0

[Explain the MPL 2.0 license in your own words]

Create a comparison table:
| Feature | MPL 2.0 | GPL | MIT |
|---------|---------|-----|-----|
| Copyleft | File-level | Strong | None |
| ... | ... | ... | ... |

Discuss:
- What makes MPL unique?
- How does it balance open source ideals with practical adoption?
- Why did Mozilla choose this license?

### 2.3 Philosophy and Values

[Discuss Mozilla Manifesto and its 10 principles]

Quote one or two principles and explain what they mean to you.

---

## 3. PART B: LINUX FOOTPRINT

### 3.1 Firefox in Linux Ecosystem

[Discuss how Firefox integrates with Linux]
- Default browser in many distributions
- Package manager availability
- Dependencies

### 3.2 Shell Scripts Overview

**Script 1: System Identity Report**
- Purpose: Gathers comprehensive system information
- Key commands used: uname, df, free, hostname
- Output: OS details, network info, disk usage, memory stats

**Script 2: FOSS Package Inspector**
- Purpose: Analyzes installed packages and checks for Firefox
- Key commands used: dpkg, apt, which
- Output: Package count, Firefox status, FOSS percentage

**Script 3: Disk and Permission Auditor**
- Purpose: Security audit of file permissions
- Key commands used: find, stat, df
- Output: Disk usage, world-writable files, SUID/SGID files

**Script 4: Log File Analyzer**
- Purpose: Parses system logs for errors and warnings
- Key commands used: grep, journalctl, wc
- Output: Error counts, recent issues, security events

**Script 5: Open Source Manifesto Generator**
- Purpose: Creates personalized FOSS manifesto
- Key commands used: read, heredoc, echo
- Output: Formatted manifesto text file

### 3.3 Script Outputs and Analysis

[INSERT SCREENSHOTS OF SCRIPT OUTPUTS HERE]

**Screenshot 1: System Identity Report Output**
[Paste screenshot or output text]

Analysis: The system is running Ubuntu 24.04 LTS with kernel version...

[Continue for all 5 scripts]

---

## 4. PART C: FOSS ECOSYSTEM

### 4.1 Mozilla Foundation

[Write about Mozilla's organizational structure]
- Non-profit foundation
- Mozilla Corporation (subsidiary)
- Revenue model (search deals, VPN, etc.)
- Mission and values

### 4.2 Contribution Model

[Explain how someone can contribute to Firefox]
- Repository: https://hg.mozilla.org/mozilla-central
- Uses Mercurial (not Git)
- Bugzilla for issue tracking
- Phabricator for code review
- Steps to contribute

### 4.3 Community and Governance

[Discuss the community aspects]
- Communication channels (Matrix, Discourse)
- Decision-making process
- Module ownership system

---

## 5. PART D: OPEN SOURCE VS PROPRIETARY

### 5.1 Firefox vs Chrome Comparison

| Aspect | Firefox | Chrome |
|--------|---------|--------|
| License | MPL 2.0 (Open Source) | Proprietary (Chromium base is open) |
| Organization | Non-profit | For-profit |
| Privacy | Privacy-focused | Data collection for ads |
| Source Code | Fully open | Partially open |
| Revenue | Search deals, donations | Advertising |
| Market Share | ~3% | ~65% |
| Engine | Gecko | Blink |

### 5.2 Analysis and Recommendations

[Write your analysis - 200-300 words]
- What are the advantages of Firefox being open source?
- What are the challenges?
- Why does browser diversity matter?
- Your personal recommendation

---

## 6. CONCLUSION

[Write 150-200 words summarizing:]
- What you learned from this project
- Key insights about Firefox and open source
- The importance of FOSS in today's world
- Future of open source software

---

## 7. REFERENCES

1. Mozilla Foundation. (2024). "About Mozilla." https://www.mozilla.org/about/
2. Mozilla. (2024). "Mozilla Public License 2.0." https://www.mozilla.org/MPL/2.0/
3. Mozilla. (2024). "The Mozilla Manifesto." https://www.mozilla.org/about/manifesto/
4. Firefox Source Docs. (2024). https://firefox-source-docs.mozilla.org/
5. Free Software Foundation. (2024). "What is Free Software?" https://www.fsf.org/about/what-is-free-software
6. [Add more references as needed]

---

## 8. APPENDIX: SCRIPT SOURCE CODE

### Script 1: system_identity.sh
```bash
[Paste the script code here]
```

### Script 2: foss_inspector.sh
```bash
[Paste the script code here]
```

[Continue for all 5 scripts]

---

## CHECKLIST BEFORE SUBMISSION

- [ ] Report is 12-16 pages
- [ ] All sections completed
- [ ] Screenshots of script outputs included
- [ ] Written in my own words (not AI generated)
- [ ] References properly cited
- [ ] GitHub repository is public
- [ ] README.md is complete
- [ ] All 5 scripts work correctly
- [ ] Spelling and grammar checked
- [ ] PDF format

---

**IMPORTANT REMINDERS:**

1. Write everything in YOUR OWN WORDS
2. Include screenshots from your actual script runs
3. Make sure GitHub repo is PUBLIC before submission
4. Test all scripts work on Linux before demo
5. Be prepared for viva questions about:
   - MPL 2.0 license details
   - How your scripts work
   - Firefox history and Mozilla Foundation
   - Difference between open source and proprietary
