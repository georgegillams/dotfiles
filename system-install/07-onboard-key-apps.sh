#!/bin/bash
. ./00-setup-type.sh

[ -d "/Applications/1Password.app" ] && open "/Applications/1Password.app"
echo "In 1Password, enable Settings > Developer > Integrate with 1Password CLI"
echo "Press Enter to continue"
read
[ -d "/Applications/Google Drive.app" ] && open "/Applications/Google Drive.app"
[ -d "/Applications/Microsoft Outlook.app" ] && open "/Applications/Microsoft Outlook.app"
[ -d "/Applications/Microsoft Outlook.app" ] && open "/Applications/Microsoft Outlook.app"
[ -d "/Applications/Slack.app" ] && open "/Applications/Slack.app"