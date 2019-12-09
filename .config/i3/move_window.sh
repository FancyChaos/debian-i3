#!/usr/bin/env bash
key=$1
curr_workspace=$(i3-msg -t get_workspaces | jq '.[] | select(.focused==true).name' | cut -d"\"" -f2)

if [ $curr_workspace == 1 ] && [ "$key" == "y" ]; then
	curr_workspace=$(i3-msg -t get_workspaces | jq '.[] | select(.focused==false).name' | cut -d"\"" -f2 | tail -1)
  	curr_workspace=$((curr_workspace+1))
elif [ "$key" == "y" ]; then
	curr_workspace=$((curr_workspace-1))
else
  	curr_workspace=$((curr_workspace+1))
fi

$(i3-msg move to workspace $curr_workspace)
$(i3-msg workspace $curr_workspace)
