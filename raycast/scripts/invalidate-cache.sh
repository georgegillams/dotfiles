#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Invalidate cache
# @raycast.mode compact

# Optional parameters:
# @raycast.icon ./github.png
# @raycast.argument1 { "type": "text", "placeholder": "Path to invalidate" }

# Documentation:
# @raycast.author George Gillams
# @raycast.authorURL https://www.georgegillams.co.uk/

cd ~/Documents/Typeform/public-main-site
echo "{\"path\":\"$@\"}" | gh workflow run custom-cache-invalidation.yml --json
gh run list --workflow=custom-cache-invalidation.yml
