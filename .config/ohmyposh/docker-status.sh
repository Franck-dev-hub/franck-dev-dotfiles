#!/usr/bin/env bash
# Docker compose status (running/down) for the current project, used by
# oh-my-posh's set_poshcontext hook via POSH_DOCKER. Cached briefly because
# `docker compose` calls the daemon and is too slow to run on every keystroke.

CACHE_TTL=5
CACHE_DIR="$HOME/.cache/oh-my-posh/docker-status"

dir="$PWD"
root=""
for _ in 1 2 3 4 5 6 7 8; do
    if [ -f "$dir/compose.yaml" ] || [ -f "$dir/compose.yml" ] ||
       [ -f "$dir/docker-compose.yaml" ] || [ -f "$dir/docker-compose.yml" ]; then
        root="$dir"
        break
    fi
    [ "$dir" = "/" ] && break
    dir="$(dirname "$dir")"
done

[ -z "$root" ] && exit 0

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

services_total=$(docker compose --project-directory "$root" config --services 2>/dev/null | grep -c .)
if [ "${services_total:-0}" -eq 0 ]; then
    printf '' | tee "$cache_file" >/dev/null
    exit 0
fi

running=$(docker compose --project-directory "$root" ps --status running -q 2>/dev/null | grep -c .)
down=$((services_total - running))
[ "$down" -lt 0 ] && down=0

output=""
[ "$running" -gt 0 ] && output="${output}<p:docker-up>↑${running}</>"
[ "$down" -gt 0 ] && output="${output}<p:docker-down>↓${down}</>"
[ -n "$output" ] && output="${output}"

printf '%s' "$output" | tee "$cache_file"
