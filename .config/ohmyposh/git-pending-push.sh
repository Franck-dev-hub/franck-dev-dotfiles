#!/usr/bin/env bash
# Commits pending push when the current branch has no upstream configured
# (the git segment's native .Ahead only works once an upstream exists).
# Compares HEAD against the remote's default branch instead.

git rev-parse --is-inside-work-tree >/dev/null 2>&1 || exit 0

# Native .Ahead already covers this case — stay silent to avoid a duplicate count.
git rev-parse --abbrev-ref '@{upstream}' >/dev/null 2>&1 && exit 0

base=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@')
[ -z "$base" ] && exit 0

count=$(git rev-list --count "origin/$base..HEAD" 2>/dev/null)
[ -n "$count" ] && [ "$count" != "0" ] && echo "$count"
