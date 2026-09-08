#!/bin/bash

input=$(cat)

# ---- Raw fields ----
cwd=$(echo "$input" | jq -r '.cwd // .workspace.current_dir // empty')
project_dir=$(echo "$input" | jq -r '.workspace.project_dir // empty')
repo_name=$(echo "$input" | jq -r '.workspace.repo.name // empty')
model_name=$(echo "$input" | jq -r '.model.display_name // .model.id // "?"')
effort_level=$(echo "$input" | jq -r '.effort.level // empty')
transcript_path=$(echo "$input" | jq -r '.transcript_path // empty')

# Get context window size from JSON (accurate), but calculate tokens from transcript
# (more accurate than total_input_tokens which excludes system prompt/tools/memory)
# See: github.com/anthropics/claude-code/issues/13652
max_context=$(echo "$input" | jq -r '.context_window.context_window_size // 200000')

# ---- Repo name (bold yellow) ----
if [[ -z "$repo_name" ]]; then
    if [[ -n "$project_dir" ]]; then
        repo_name=$(basename "$project_dir")
    elif [[ -n "$cwd" ]]; then
        repo_name=$(basename "$cwd")
    else
        repo_name="?"
    fi
fi

# ---- Git branch (skip optional locks) ----
branch=""
if [[ -n "$cwd" && -d "$cwd" ]]; then
    branch=$(git -C "$cwd" --no-optional-locks branch --show-current 2>/dev/null)
fi

# ---- Code velocity: uncommitted churn vs HEAD ----
added=0
removed=0
if [[ -n "$branch" ]]; then
    shortstat=$(git -C "$cwd" --no-optional-locks diff --shortstat HEAD 2>/dev/null)
    added=$(echo "$shortstat" | grep -oE '[0-9]+ insertion' | grep -oE '[0-9]+')
    removed=$(echo "$shortstat" | grep -oE '[0-9]+ deletion' | grep -oE '[0-9]+')
    [[ -z "$added" ]] && added=0
    [[ -z "$removed" ]] && removed=0
fi

# ---- 24-bit truecolor helpers ----
rgb()   { printf '\033[38;2;%d;%d;%dm' "$1" "$2" "$3"; }
bold()  { printf '\033[1m'; }
reset() { printf '\033[0m'; }

C_RESET=$(reset)
C_SEP=$(rgb 90 90 90)                 # dim gray pipe separators
C_REPO="$(bold)$(rgb 235 200 30)"     # bold yellow
C_BRANCH="$(bold)$(rgb 40 200 210)"   # bold cyan
C_ADD=$(rgb 60 200 90)
C_REMOVE=$(rgb 220 60 50)

SEP=" ${C_SEP}|${C_RESET} "

# ---- Model color (per model) ----
case "$(echo "$model_name" | tr '[:upper:]' '[:lower:]')" in
    *opus*)   C_MODEL=$(rgb 230 100 40) ;;   # orange
    *sonnet*) C_MODEL=$(rgb 70 140 230) ;;   # blue
    *haiku*)  C_MODEL=$(rgb 190 110 230) ;;  # purple
    *)        C_MODEL=$(rgb 200 200 200) ;;  # neutral gray fallback
esac

# ---- Effort color (per effort level) ----
case "$effort_level" in
    low)    C_EFFORT=$(rgb 60 200 90) ;;
    medium) C_EFFORT=$(rgb 220 200 0) ;;
    high)   C_EFFORT=$(rgb 230 140 0) ;;
    xhigh)  C_EFFORT=$(rgb 230 80 40) ;;
    max)    C_EFFORT=$(rgb 220 40 20) ;;
    *)      C_EFFORT="" ;;
esac

# Calculate context percentage from transcript
if [[ -n "$transcript_path" && -f "$transcript_path" ]]; then
    context_length=$(jq -s '
        map(select(.message.usage and .isSidechain != true and .isApiErrorMessage != true)) |
        last |
        if . then
            (.message.usage.input_tokens // 0) +
            (.message.usage.cache_read_input_tokens // 0) +
            (.message.usage.cache_creation_input_tokens // 0)
        else 0 end
    ' < "$transcript_path")
else
    context_length=0
fi

# 20k baseline: includes system prompt (~3k), tools (~15k), memory (~300),
# plus ~2k for git status, env block, XML framing, and other dynamic context
baseline=20000

if [[ "$context_length" -gt 0 ]]; then
    pct=$((context_length * 100 / max_context))
else
    # At conversation start, ~20k baseline is already loaded
    pct=$((baseline * 100 / max_context))
fi
[[ $pct -gt 100 ]] && pct=100
[[ $pct -lt 0 ]] && pct=0

# ---- Percentage color by usage level (green -> yellow -> red) ----
pct_color() {
    if   (( $1 < 15 )); then rgb 60 140 230   # blue
    elif (( $1 < 40 )); then rgb 60 200 90    # green
    elif (( $1 < 60 )); then rgb 220 200 0    # yellow
    elif (( $1 < 85 )); then rgb 230 140 0    # orange
    else                      rgb 220 40 20   # red
    fi
}
C_PCT=$(pct_color "$pct")

# ---- Rate limit usage (5h / 7d windows) ----
C_DIM=$(rgb 120 120 120)

fmt_countdown() {
    local remaining=$(( $1 - $(date +%s) ))
    (( remaining < 0 )) && remaining=0
    local days=$(( remaining / 86400 ))
    local hours=$(( (remaining % 86400) / 3600 ))
    local mins=$(( (remaining % 3600) / 60 ))
    if   (( days  > 0 )); then printf '%dd%dh' "$days" "$hours"
    elif (( hours > 0 )); then printf '%dh%dm' "$hours" "$mins"
    else                        printf '%dm' "$mins"
    fi
}

rl_5h_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage | select(. != null) | round')
rl_5h_reset=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')
rl_7d_pct=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage | select(. != null) | round')
rl_7d_reset=$(echo "$input" | jq -r '.rate_limits.seven_day.resets_at // empty')

rl_5h_segment=""
if [[ -n "$rl_5h_pct" ]]; then
    C_RL5H=$(pct_color "$rl_5h_pct")
    rl_5h_segment="${C_DIM}5h ${C_RESET}${C_RL5H}${rl_5h_pct}%${C_RESET} ${C_DIM}($(fmt_countdown "$rl_5h_reset"))${C_RESET}"
fi

rl_7d_segment=""
if [[ -n "$rl_7d_pct" ]]; then
    C_RL7D=$(pct_color "$rl_7d_pct")
    rl_7d_segment="${C_DIM}7d ${C_RESET}${C_RL7D}${rl_7d_pct}%${C_RESET} ${C_DIM}($(fmt_countdown "$rl_7d_reset"))${C_RESET}"
fi

# ---- Assemble segments, skipping empty ones, joined by dim-gray pipes ----
line1_segments=()
line1_segments+=("${C_REPO}${repo_name}${C_RESET}")
[[ -n "$branch" ]] && line1_segments+=("${C_BRANCH}${branch}${C_RESET}")
line1_segments+=("${C_MODEL}${model_name}${C_RESET}")
[[ -n "$effort_level" ]] && line1_segments+=("${C_EFFORT}${effort_level}${C_RESET}")

line2_segments=()
line2_segments+=("${C_PCT}${pct}%${C_RESET}")
if [[ "$added" -gt 0 || "$removed" -gt 0 ]]; then
    line2_segments+=("${C_ADD}+${added}${C_RESET}${C_SEP}/${C_RESET}${C_REMOVE}-${removed}${C_RESET}")
fi
[[ -n "$rl_5h_segment" ]] && line2_segments+=("$rl_5h_segment")
[[ -n "$rl_7d_segment" ]] && line2_segments+=("$rl_7d_segment")

join() {
    local -n arr=$1
    local out=""
    for i in "${!arr[@]}"; do
        [[ $i -gt 0 ]] && out+="$SEP"
        out+="${arr[$i]}"
    done
    printf '%s' "$out"
}

printf '%b\n%b\n' "$(join line1_segments)" "$(join line2_segments)"
