# RISK SCORING RUBRIC — Self-Surveillance Cell

**Classification:** INTERNAL — Team Use  
**Version:** 1.0  
**Owner:** Intelligence Analyst

---

## OVERALL RISK LEVELS

| Level | Color | Score Range | Definition |
|-------|-------|-------------|------------|
| CRITICAL | █ Red | 45-60 | Active compromise or imminent threat. PII leaked on dark web, credentials breached, identity at immediate risk. Daily reporting required. |
| HIGH | █ Orange | 30-44 | Significant exposure found. Multiple data broker listings, trackable digital footprint, moderate linkage risk. Action required this week. |
| MEDIUM | █ Yellow | 15-29 | Some exposure exists. Old accounts, minor data broker listings, low linkage risk. Routine monitoring acceptable. |
| LOW | █ Green | 0-14 | Minimal exposure. Few digital footprints, no known leaks, difficult to track. Standard maintenance. |

---

## RISK DOMAIN SCORING (Each /10)

### 1. Identity Exposure (10 points)
| Score | Criteria |
|-------|----------|
| 0-2 | No PII found in any public source. Data broker opt-outs complete. |
| 3-4 | Name and general location found. 1-2 data broker listings. |
| 5-6 | Full name, address, DOB, or phone number exposed. 3-5 data broker listings. |
| 7-8 | Full PII package (name+address+DOB+SSN/passport) found. Multiple broker listings. |
| 9-10 | Complete identity dossier publicly available. Family member info also exposed. |

### 2. Credential Security (10 points)
| Score | Criteria |
|-------|----------|
| 0-2 | No credentials in known breaches. MFA active on all accounts. |
| 3-4 | 1-2 credentials found in old breaches. MFA on critical accounts. |
| 5-6 | 3-5 credentials leaked. Some accounts lack MFA. |
| 7-8 | 5+ credentials leaked. Reused passwords. Password manager not used. |
| 9-10 | Active credentials in recent breaches. No MFA. Password reuse across critical accounts. |

### 3. Location Privacy (10 points)
| Score | Criteria |
|-------|----------|
| 0-2 | Location services off. No geotagged social posts. VPN always on. |
| 3-4 | Occasional location sharing. Home address not publicly linked. |
| 5-6 | Home address findable. Social media reveals daily patterns. |
| 7-8 | Real-time location visible. Home/work addresses easily found. |
| 9-10 | Precise real-time tracking possible. Routines predictable. Address and workplace public. |

### 4. Financial Exposure (10 points)
| Score | Criteria |
|-------|----------|
| 0-2 | No financial data found. Credit frozen. |
| 3-4 | Bank/credit card name visible. No account numbers leaked. |
| 5-6 | Partial financial info leaked. Credit card in breach database. |
| 7-8 | Account numbers exposed. Fraud attempts possible. |
| 9-10 | Full financial profile available. SSN/TIN exposed. Active fraud risk. |

### 5. Reputational Risk (10 points)
| Score | Criteria |
|-------|----------|
| 0-2 | Clean digital reputation. No controversial content. |
| 3-4 | Minor old social content. Easily dismissable. |
| 5-6 | Past content that could be used against principal. |
| 7-8 | Deleted/private content archived elsewhere. Doxxing potential. |
| 9-10 | Active smear campaigns. Embarrassing content easily surfaced. |

### 6. Physical Safety (10 points)
| Score | Criteria |
|-------|----------|
| 0-2 | Home address not publicly linked. No threats received. |
| 3-4 | Address findable but no active threat. |
| 5-6 | Address public. Professional info easily links to home. |
| 7-8 | Address and daily patterns public. Prior harassment/threats. |
| 9-10 | Doxxed with personal safety at risk. Active threats. |

---

## TRACKABILITY SCORING (/100)

The trackability score measures how easily an adversary could trace the principal's digital identity.

### Component Scores (Each /10 unless noted)

| Component | 0-2 (Excellent) | 3-5 (Moderate) | 6-8 (Poor) | 9-10 (Critical) |
|-----------|----------------|----------------|------------|-----------------|
| Device Fingerprinting | Unique browser config, anti-fingerprint extensions | Standard browser, some randomization | Common fingerprint, no protection | Highly unique, easily identified |
| Browser Leakage | WebRTC/headers blocked, no leaks | Partial protection | Standard browser | Full leakage (IP, DNS, WebRTC) |
| Location Data | GPS off, no geotags, VPN | Minimal sharing | Occasional location sharing | Location constantly exposed |
| Cross-Platform Linkage | No linked usernames/emails across platforms | Some separation | Several platforms linked by common identity | One identity across everything |
| Ad Tracker Mapping | Ad/tracker blockers active | Some blocking | Standard browsing | No blocking, heavily tracked |
| Social Media Footprint | Anonymous or locked-down profiles | Limited public info | Active with real identity | Hyperactive, full identity exposed |

### Composite Scoring
- **0-20:** Excellent — Very difficult to trace
- **21-40:** Good — Some effort required to trace
- **41-60:** Moderate — Average person level
- **61-80:** Poor — Easily traceable
- **81-100:** Critical — Trivial to trace in real time

---

## DETECTION-TO-ALERT LATENCY TARGETS

| Severity | Target Latency | Escalation |
|----------|---------------|------------|
| 🔴 Critical (credential leak, PII exposure on dark web) | < 1 hour | Immediate SMS/email + report |
| 🟡 High (new account found, data broker listing) | < 4 hours | Same-day report inclusion |
| 🟢 Medium (minor exposure, old account discovered) | < 24 hours | Next daily report |
| ⚪ Low (informational, non-identifying) | < 72 hours | Weekly summary |

---

## RECOMMENDED RESPONSE TIMELINES

| Severity | Response Window | Actions Required |
|----------|----------------|------------------|
| 🔴 Critical | < 24 hours | Password reset, credit freeze, account lockdown, legal consultation |
| 🟡 High | < 72 hours | Account cleanup, opt-out requests, password changes |
| 🟢 Medium | < 1 week | Remediation planning, account deletion |
| ⚪ Low | < 1 month | Track and monitor |