#!/usr/bin/env bash

S=(0 "" "" "󰘐" "" "󰙯" "󰓓" "󰗃" "" "󰷛")

update() {
	for i in "${!S[@]}"; do
		C[i]="workspace"
	done

	monitor_info=$(hyprctl monitors -j)
	i_focus_scr0=$(echo "$monitor_info" | jq '.[] | select(.id == 0).activeWorkspace.id')
	C[i_focus_scr0]="${C[i_focus_scr0]} focused left"
	i_focus_scr0=$(echo "$monitor_info" | jq '.[] | select(.id == 1).activeWorkspace.id')
	C[i_focus_scr0]="${C[i_focus_scr0]} focused right"

	# workspace_focused_monitor_1=$(echo $monitor_info | jq '.[] | select(.id == 1).activeWorkspace.id')
	for i in $(hyprctl workspaces -j | jq '.[] | del(select(.id == -99)) | .id'); do
		C[i]="${C[i]} occupied"
	done

	echo \
		"(eventbox :onscroll \"echo {} | sed -e 's/up/-1/g' -e 's/down/+1/g' | xargs hyprctl dispatch workspace\" \
        (box \
            :class \"workspaces\" \
            :spacing 2 \
            (button :onclick \"bar/scripts/dispatch.sh 1 --focus-workspace\" :onrightclick \"bar/scripts/dispatch.sh 1 --move-workspace\" \
                    :class \"${C[1]}\" \"${S[1]} ₁\") \
            (button :onclick \"bar/scripts/dispatch.sh 2 --focus-workspace\" :onrightclick \"bar/scripts/dispatch.sh 2 --move-workspace\" \
                    :class \"${C[2]}\" \"${S[2]} ₂\") \
            (button :onclick \"bar/scripts/dispatch.sh 3 --focus-workspace\" :onrightclick \"bar/scripts/dispatch.sh 3 --move-workspace\" \
                    :class \"${C[3]}\" \"${S[3]} ₃\") \
            (button :onclick \"bar/scripts/dispatch.sh 4 --focus-workspace\" :onrightclick \"bar/scripts/dispatch.sh 4 --move-workspace\" \
                    :class \"${C[4]}\" \"${S[4]} ₄\") \
            (button :onclick \"bar/scripts/dispatch.sh 5 --focus-workspace\" :onrightclick \"bar/scripts/dispatch.sh 5 --move-workspace\" \
                    :class \"${C[5]}\" \"${S[5]} ₅\") \
            (button :onclick \"bar/scripts/dispatch.sh 6 --focus-workspace\" :onrightclick \"bar/scripts/dispatch.sh 6 --move-workspace\" \
                    :class \"${C[6]}\" \"${S[6]} ₆\") \
            (button :onclick \"bar/scripts/dispatch.sh 7 --focus-workspace\" :onrightclick \"bar/scripts/dispatch.sh 7 --move-workspace\" \
                    :class \"${C[7]}\" \"${S[7]} ₇\") \
            (button :onclick \"bar/scripts/dispatch.sh 8 --focus-workspace\" :onrightclick \"bar/scripts/dispatch.sh 8 --move-workspace\" \
                    :class \"${C[8]}\" \"${S[8]} ₈\") \
            (button :onclick \"bar/scripts/dispatch.sh 9 --focus-workspace\" :onrightclick \"bar/scripts/dispatch.sh 9 --move-workspace\" \
                    :class \"${C[9]}\" \"${S[9]} ₉\") \
        )\
    )"
}

# https://wiki.hyprland.org/Configuring/Expanding-functionality/
update
socat -u "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" - | while read -r; do
    update
done
