#!/bin/bash

let openInBlocksOf=5

# Get list of apps from /Applications/
let i=0
for app in /Applications/*; do
    apps[$i]="$app"
    let i++
done

let numberOfApps=${#apps[@]}

let i=0
let openUpTo=$((openInBlocksOf))
while [ $i -lt $numberOfApps ]; do
    while [ $i -lt $openUpTo -a $i -lt $numberOfApps  ]; do
        echo "Opening ${apps[$i]}"
        open "${apps[$i]}"
        let i++
    done
    echo "Press any key to continue"
    read
    openUpTo=$((openUpTo + openInBlocksOf))
done

