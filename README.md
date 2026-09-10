# Intelligence Reports — Self-Surveillance Cell

## Directory Structure

```
reports/
├── README.md                       ← This file
├── REPORT_TEMPLATE.md              ← Master template for daily reports
├── RISK_SCORING_RUBRIC.md          ← Risk scoring methodology
├── KPI_TRACKER.md                  ← KPI tracking dashboard
├── compile_report.sh               ← Auto-compilation script
├── PD-DIR-YYYYMMDD-NNN.md         ← Daily reports (RFC 2119 naming)
└── archive/                        ← Archived reports (older than 30 days)
```

## Report Naming Convention

`PD-DIR-YYYYMMDD-NNN.md`

- `PD` — Project Degeneres
- `DIR` — Daily Intelligence Report
- `YYYYMMDD` — Date of the report period
- `NNN` — Sequential number (for multiple reports on same day)

Example: `PD-DIR-20260705-001.md`

## Workflow

### Daily Process
1. **Team members** complete their tasks and save findings to `/home/team/shared/`
2. **Intelligence Analyst** runs `bash compile_report.sh` to auto-compile findings
3. **Intelligence Analyst** reviews and fills in analyst sections (risk scoring, action items, commentary)
4. **Report is saved** as `PD-DIR-YYYYMMDD-NNN.md`
5. **Principal is notified** with link to report

### Report Lifecycle
- **Draft** → Auto-compiled, needs analyst review
- **Published** → Reviewed and finalized by Intelligence Analyst
- **Archived** → Moved to `archive/` after 30 days

## Classification Levels
- **CONFIDENTIAL — Principal Only:** Full report with all details
- **INTERNAL — Team Use:** Rubrics, trackers, procedures
- **PUBLIC:** Summarized, sanitized versions (if needed)

## Risk Scoring
See `RISK_SCORING_RUBRIC.md` for the complete scoring methodology.
Trackability score of 0-100 (lower = better). Composite risk score of 0-60.

## Team Member Artifact Locations
Team members save their findings in subdirectories under `/home/team/shared/`:
- `agent-recon-osint-lead` → Footprint mapping, accounts, breaches, data brokers
- `agent-dark-web-hunter` → Dark web, Telegram, Discord, paste sites
- `agent-counter-intel-analyst` → Trackability, fingerprinting, adversarial sim
- `agent-infra-engineer` → Dashboards, alerts, monitoring pipelines

## KPIs Tracked
1. Exposure Discovery Rate (new items/week)
2. Dark-Web Coverage Breadth (score 0-100)
3. Trackability Score (0-100, lower = better)
4. Detection-to-Alert Latency (minutes/hours)
5. Remediation Completion Rate (%)