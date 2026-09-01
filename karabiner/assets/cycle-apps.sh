#!/bin/bash
# Cycle through open apps, Cmd+Tab style, one press at a time.
# Quick repeated presses walk deeper into the most-recently-used list
# (2nd, 3rd, 4th most recent...). Pausing longer than RESET_SECS starts
# a fresh cycle from whatever is frontmost then.
# The MRU order is snapshotted at the start of each cycle so pressing
# through the list doesn't reshuffle it mid-cycle.

# Pass "back" as $1 to step backwards through the cycle.
STEP=1
[ "$1" = "back" ] && STEP=-1

RESET_SECS=3
STATE="${TMPDIR:-/tmp}/appcycle.state"
# Skipped in rotation: Wispr Flow (triggered via its own hotkey) and
# Finder (always running, can't be quit, rarely the target).
EXCLUDES="com.electron.wispr-flow com.apple.finder"

now=$(date +%s)
fresh=1
apps=()
if [ -f "$STATE" ]; then
    {
        read -r ts
        read -r idx
        while read -r b; do apps+=("$b"); done
    } < "$STATE"
    if [ $((now - ts)) -le "$RESET_SECS" ] && [ "${#apps[@]}" -gt 0 ]; then
        fresh=0
    fi
fi

if [ "$fresh" -eq 1 ]; then
    apps=()
    for tok in $(lsappinfo visibleProcessList); do
        bid=$(lsappinfo info -only bundleid "${tok%:}" | cut -d'"' -f4)
        case " $EXCLUDES " in
            *" $bid "*) ;;
            *) [ -n "$bid" ] && apps+=("$bid") ;;
        esac
    done
    idx=0
fi

[ "${#apps[@]}" -lt 2 ] && exit 0

idx=$(( (idx + STEP + ${#apps[@]}) % ${#apps[@]} ))
open -b "${apps[$idx]}"

{
    printf '%s\n%s\n' "$now" "$idx"
    printf '%s\n' "${apps[@]}"
} > "$STATE"
