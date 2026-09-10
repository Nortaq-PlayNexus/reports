#!/bin/bash
# ==============================================================================
# compile_report.sh — Intelligence Report Compilation Script
# ==============================================================================
# This script gathers findings from all team members' completed work in
# /home/team/shared/ and compiles them into a daily intelligence report.
#
# Usage: ./compile_report.sh [date]
#   date: Optional date in YYYY-MM-DD format (default: today)
#
# Output: /home/team/shared/reports/PD-DIR-YYYYMMDD-NNN.md
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPORTS_DIR="${SCRIPT_DIR}"
SHARED_DIR="/home/team/shared"

# Date handling
DATE="${1:-$(date +%Y-%m-%d)}"
DATE_FORMATTED=$(date -d "$DATE" "+%B %d, %Y" 2>/dev/null || echo "$DATE")
DATE_STAMP=$(date -d "$DATE" "+%Y%m%d" 2>/dev/null || echo "$DATE")
SEQ_NUM=$(date -d "$DATE" "+%s" 2>/dev/null || echo "001")
SEQ_NUM="${SEQ_NUM: -3}"

REPORT_FILE="${REPORTS_DIR}/PD-DIR-${DATE_STAMP}-${SEQ_NUM}.md"

echo "=== Intelligence Report Compiler ==="
echo "Date: $DATE_FORMATTED"
echo "Output: $REPORT_FILE"
echo ""

# ------------------------------------------------------------------------------
# Section 1: Gather findings from team member artifacts
# ------------------------------------------------------------------------------
echo "[*] Scanning for team member artifacts..."

# Find all markdown, JSON, and text files in team shared directories
# that might contain findings
RECON_FILES=$(find "$SHARED_DIR" -maxdepth 3 -name "*.md" -o -name "*.json" -o -name "*.txt" 2>/dev/null | sort)
DARKWEB_FILES=$(find "$SHARED_DIR" -maxdepth 3 -name "*dark*" -o -name "*deep*" -o -name "*leak*" -o -name "*breach*" 2>/dev/null | sort)
COUNTERINTEL_FILES=$(find "$SHARED_DIR" -maxdepth 3 -name "*track*" -o -name "*fingerprint*" -o -name "*counter*" -o -name "*adversar*" 2>/dev/null | sort)
INFRA_FILES=$(find "$SHARED_DIR" -maxdepth 3 -name "*infra*" -o -name "*dashboard*" -o -name "*alert*" -o -name "*monitor*" 2>/dev/null | sort)
ALL_FINDINGS=$(echo "$RECON_FILES" "$DARKWEB_FILES" "$COUNTERINTEL_FILES" "$INFRA_FILES" | tr ' ' '\n' | sort -u)

FINDINGS_COUNT=$(echo "$ALL_FINDINGS" | grep -c '.' || true)
echo "[*] Found $FINDINGS_COUNT potential finding files"

# ------------------------------------------------------------------------------
# Section 2: Check team database for completed tasks
# ------------------------------------------------------------------------------
echo "[*] Checking team database for completed tasks..."
COMPLETED_TASKS=$(team-db "SELECT id, title, assigned_to, result FROM tasks WHERE status = 'done'" 2>/dev/null || echo "[]")
echo "[*] Task data retrieved from database"

# Function to extract JSON values (simple approach)
get_json_value() {
    echo "$1" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('$2',''))" 2>/dev/null || echo "—"
}

# ------------------------------------------------------------------------------
# Section 3: Build the report
# ------------------------------------------------------------------------------
echo "[*] Building report..."

cat > "$REPORT_FILE" << EOF
# DAILY INTELLIGENCE REPORT — ${DATE_FORMATTED}

**Classification:** CONFIDENTIAL — Principal Only
**Report ID:** PD-DIR-${DATE_STAMP}-${SEQ_NUM}
**Prepared by:** Intelligence Analyst (Compiled Automatically)
**Period covered:** ${DATE_FORMATTED}

---

## EXECUTIVE SUMMARY

*This report was automatically compiled from team member findings. Analysis sections should be filled in by the Intelligence Analyst.*

- **Overall Risk Level:** █ PENDING ASSESSMENT
- **Trackability Score:** PENDING
- **New Exposures Found:** PENDING
- **Critical Action Items:** PENDING

---

## 1. NEW EXPOSURES DISCOVERED

### 1.1 Recon & OSINT Lead Findings
*Findings from: Full digital footprint mapping — accounts, leaks, PII, data brokers*

$(team-db "SELECT result FROM tasks WHERE assigned_to = 'agent-recon-osint-lead' AND status = 'done' ORDER BY id DESC LIMIT 1" 2>/dev/null | python3 -c "import sys,json; data=json.load(sys.stdin); print(data[0]['result'] if data else '_No findings yet — task in progress._')" 2>/dev/null || echo "_No findings yet — task in progress._")

### 1.2 Data Broker Listings
*Referenced artifacts:*
$(echo "$ALL_FINDINGS" | while read -r f; do
    if [[ "$f" == *"broker"* ]] || [[ "$f" == *"pii"* ]] || [[ "$f" == *"exposure"* ]]; then
        echo "- \`$f\`"
    fi
done)

---

## 2. DARK WEB & DEEP WEB FINDINGS

### 2.1 Dark Web Hunter Findings
*Findings from: Deep & dark web monitoring for data leaks and mentions*

$(team-db "SELECT result FROM tasks WHERE assigned_to = 'agent-dark-web-hunter' AND status = 'done' ORDER BY id DESC LIMIT 1" 2>/dev/null | python3 -c "import sys,json; data=json.load(sys.stdin); print(data[0]['result'] if data else '_No findings yet — task in progress._')" 2>/dev/null || echo "_No findings yet — task in progress._")

### 2.2 Sources Monitored
*Referenced artifacts:*
$(echo "$ALL_FINDINGS" | while read -r f; do
    if [[ "$f" == *"dark"* ]] || [[ "$f" == *"deep"* ]] || [[ "$f" == *"leak"* ]] || [[ "$f" == *"breach"* ]] || [[ "$f" == *"telegram"* ]] || [[ "$f" == *"discord"* ]]; then
        echo "- \`$f\`"
    fi
done)

---

## 3. TRACKABILITY & COUNTER-INTELLIGENCE

### 3.1 Counter-Intel Analyst Findings
*Findings from: Counter-intelligence analysis — trackability score, fingerprinting, adversarial sim*

$(team-db "SELECT result FROM tasks WHERE assigned_to = 'agent-counter-intel-analyst' AND status = 'done' ORDER BY id DESC LIMIT 1" 2>/dev/null | python3 -c "import sys,json; data=json.load(sys.stdin); print(data[0]['result'] if data else '_No findings yet — task in progress._')" 2>/dev/null || echo "_No findings yet — task in progress._")

### 3.2 Trackability Score Breakdown
*Referenced artifacts:*
$(echo "$ALL_FINDINGS" | while read -r f; do
    if [[ "$f" == *"track"* ]] || [[ "$f" == *"fingerprint"* ]] || [[ "$f" == *"counter"* ]] || [[ "$f" == *"adversar"* ]]; then
        echo "- \`$f\`"
    fi
done)

---

## 4. ADVERSARIAL SIMULATION RESULTS

*Results from adversarial simulation against the principal.*

$(team-db "SELECT result FROM tasks WHERE assigned_to LIKE '%counter%intel%' AND status = 'done' AND result LIKE '%adversar%' ORDER BY id DESC LIMIT 1" 2>/dev/null | python3 -c "import sys,json; data=json.load(sys.stdin); print(data[0]['result'] if data else '_No simulation results yet._')" 2>/dev/null || echo "_No simulation results yet._")

---

## 5. RISK ASSESSMENT

**Overall Risk Level: █ PENDING ASSESSMENT**
*Apply the rubric in RISK_SCORING_RUBRIC.md to calculate.*

| Risk Domain | Score | Rationale |
|-------------|-------|-----------|
| Identity Exposure | /10 | — |
| Credential Security | /10 | — |
| Location Privacy | /10 | — |
| Financial Exposure | /10 | — |
| Reputational Risk | /10 | — |
| Physical Safety | /10 | — |
| **Composite Risk** | **/60** | — |

---

## 6. KPI TRACKER

| KPI | Current Value | Previous Value | Target | Status |
|-----|--------------|----------------|--------|--------|
| Exposure Discovery Rate (new/week) | — | — | ≥ 5 | ⚪ |
| Dark-Web Coverage Breadth | — | — | ≥ 80 | ⚪ |
| Trackability Score | — | — | ≤ 20 | ⚪ |
| Detection-to-Alert Latency | — | — | < 1 hr | ⚪ |
| Remediation Completion Rate | —% | —% | ≥ 80% | ⚪ |

*See full KPI tracker at: \`KPI_TRACKER.md\`*

---

## 7. ACTION ITEMS

*(To be filled by Intelligence Analyst after reviewing all findings.)*

### 7.1 Immediate (This Week)
| # | Action | Priority | Assigned To | Status |
|---|--------|----------|-------------|--------|
| — | — | — | — | — |

### 7.2 Short-Term (Next 2 Weeks)
| # | Action | Priority | Notes |
|---|--------|----------|-------|
| — | — | — | — |

---

## 8. APPENDIX

### 8.1 Source Artifacts Referenced This Report
$(echo "$ALL_FINDINGS" | while read -r f; do echo "- \`$f\`"; done)

### 8.2 Completed Tasks This Period
$(team-db "SELECT id, title, assigned_to, status FROM tasks WHERE status = 'done' ORDER BY id" 2>/dev/null | python3 -c "
import sys, json
data = json.load(sys.stdin)
for t in data:
    print(f\"- [{t['status']}] {t['title']} ({t['assigned_to']})\")
" 2>/dev/null || echo "- No completed tasks yet.")

---

*Report auto-compiled: $(date "+%Y-%m-%d %H:%M:%S UTC")*
*Next manual review needed: Intelligence Analyst should fill in all PENDING and — fields.*
EOF

echo ""
echo "=== Report compiled successfully ==="
echo "Output: $REPORT_FILE"
echo ""
echo "NOTE: This is an auto-compiled draft. The Intelligence Analyst should:"
echo "  1. Review all PENDING and — fields"
echo "  2. Apply risk scoring from the rubric"
echo "  3. Fill in action items based on findings"
echo "  4. Add analyst commentary and context"