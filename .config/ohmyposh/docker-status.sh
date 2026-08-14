#!/usr/bin/env bash
# Docker compose status (running/down) for the current project, used by
# oh-my-posh's set_poshcontext hook via POSH_DOCKER. Cached briefly because
# `docker compose` calls the daemon and is too slow to run on every keystroke.

CACHE_TTL=5
CACHE_DIR="$HOME/.cache/oh-my-posh/docker-status"

has_compose_file() {
    local d="$1"
    [ -d "$d" ] || return 1
    local f
    for f in "$d"/compose.yaml "$d"/compose.yml "$d"/docker-compose.yaml "$d"/docker-compose.yml; do
        [ -f "$f" ] && return 0
    done
    # env-specific variants: compose.dev.yaml, compose.preprod.yaml, ...
    for f in "$d"/compose.*.y*ml "$d"/docker-compose.*.y*ml; do
        [ -f "$f" ] && return 0
    done
    return 1
}

dir="$PWD"
project=""
root=""
for _ in 1 2 3 4 5 6 7 8; do
    for sub in "" docker .docker deploy; do
        candidate="$dir"
        [ -n "$sub" ] && candidate="$dir/$sub"
        if has_compose_file "$candidate"; then
            project="$dir"
            root="$candidate"
            break 2
        fi
    done
    [ "$dir" = "/" ] && break
    dir="$(dirname "$dir")"
done

[ -z "$root" ] && exit 0

# Find the actual compose file so we can pass it with -f; running docker
# compose from $project (not $root) lets it auto-load a project-root .env.
compose_file=""
for f in "$root"/compose.yaml "$root"/compose.yml "$root"/docker-compose.yaml "$root"/docker-compose.yml "$root"/compose.*.y*ml "$root"/docker-compose.*.y*ml; do
    [ -f "$f" ] && compose_file="$f" && break
done
[ -z "$compose_file" ] && exit 0

mkdir -p "$CACHE_DIR"
cache_file="$CACHE_DIR/$(printf '%s' "$root" | md5sum | cut -d' ' -f1)"

if [ -f "$cache_file" ]; then
    now=$(date +%s)
    mtime=$(stat -c %Y "$cache_file" 2>/dev/null || echo 0)
    if [ $((now - mtime)) -lt "$CACHE_TTL" ]; then
        cat "$cache_file"
        exit 0
    fi
fi

services_total=$(docker compose -f "$compose_file" --project-directory "$project" config --services 2>/dev/null | grep -c .)
if [ "${services_total:-0}" -eq 0 ]; then
    printf '' | tee "$cache_file" >/dev/null
    exit 0
fi

running=$(docker compose -f "$compose_file" --project-directory "$project" ps --status running -q 2>/dev/null | grep -c .)
down=$((services_total - running))
[ "$down" -lt 0 ] && down=0

output=""
[ "$running" -gt 0 ] && output="${output}<p:docker-up>↑${running}</>"
[ "$down" -gt 0 ] && output="${output}<p:docker-down>↓${down}</>"
[ -n "$output" ] && output="${output} "

printf '%s' "$output" | tee "$cache_file"
