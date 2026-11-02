#!/bin/bash

# Build Teams' accessibility tree ahead of the first Stream Deck press. Intended to run when Teams opens:
# Teams loads its UI over several seconds, so keep walking until the node count roughly stops changing.

AX="$(dirname "${BASH_SOURCE[0]}")/teams-ax.sh"

prev=0
for _ in $(seq 1 15); do
    if ! count="$("$AX" warm 2>&1)"; then
        # Teams may not have registered yet just after launch; any other error (e.g. not trusted) won't fix itself.
        if [ "$count" != "MSTeams not running" ]; then
            echo "$count" >&2
            exit 1
        fi
        count=0
    fi
    # Live content (chat, presence) shifts the count slightly, so treat a small change as settled.
    if [ "$count" -gt 50 ] && [ $((count - prev)) -le 5 ] && [ $((prev - count)) -le 5 ]; then
        echo "Teams AX warm ($count nodes)"
        exit 0
    fi
    prev="$count"
    sleep 2
done

echo "Teams AX did not settle (last count: $prev)" >&2
exit 1
