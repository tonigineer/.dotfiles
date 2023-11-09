#!/usr/bin/env bash

S=(0 "" "󰘐" "" "󰙯" "" "󰓓" "󰗃" "" "󰷛")
        # "urgent": ""

update() {
    for i in "${!S[@]}"; do
        C[$i]="workspace"
    done

    monitor_info=$(hyprctl monitors -j)
    i_focus_scr0=$(echo $monitor_info | jq '.[] | select(.id == 0).activeWorkspace.id')
    C[i_focus_scr0]="${C[i_focus_scr0]} focused"
    i_focus_scr0=$(echo $monitor_info | jq '.[] | select(.id == 1).activeWorkspace.id')
    C[i_focus_scr0]="${C[i_focus_scr0]} focused"

    # workspace_focused_monitor_1=$(echo $monitor_info | jq '.[] | select(.id == 1).activeWorkspace.id')
    workspaces_occupied=$(hyprctl workspaces -j | jq '.[] | del(select(.id == -99)) | .id')
    for i in $(hyprctl workspaces -j | jq '.[] | del(select(.id == -99)) | .id'); do
        C[i]="${C[i]} occupied"
    done


    echo \
    "(eventbox :onscroll \"echo {} | sed -e 's/up/-1/g' -e 's/down/+1/g' | xargs hyprctl dispatch workspace\" \
        (box \
            :class \"workspaces\" \
            :spacing 2 \
            (button :onclick \"../scripts/dispatch.sh 1 --focus-workspace\" :onrightclick \"../scripts/dispatch.sh 1 --move-workspace\" \
                    :class \"${C[1]}\" \"${S[1]} ₁\") \
            (button :onclick \"../scripts/dispatch.sh 2 --focus-workspace\" :onrightclick \"../scripts/dispatch.sh 2 --move-workspace\" \
                    :class \"${C[2]}\" \"${S[2]} ₂\") \
            (button :onclick \"../scripts/dispatch.sh 3 --focus-workspace\" :onrightclick \"../scripts/dispatch.sh 3 --move-workspace\" \
                    :class \"${C[3]}\" \"${S[3]} ₃\") \
            (button :onclick \"../scripts/dispatch.sh 4 --focus-workspace\" :onrightclick \"../scripts/dispatch.sh 4 --move-workspace\" \
                    :class \"${C[4]}\" \"${S[4]} ₄\") \
            (button :onclick \"../scripts/dispatch.sh 5 --focus-workspace\" :onrightclick \"../scripts/dispatch.sh 5 --move-workspace\" \
                    :class \"${C[5]}\" \"${S[5]} ₅\") \
            (button :onclick \"../scripts/dispatch.sh 6 --focus-workspace\" :onrightclick \"../scripts/dispatch.sh 6 --move-workspace\" \
                    :class \"${C[6]}\" \"${S[6]} ₆\") \
            (button :onclick \"../scripts/dispatch.sh 7 --focus-workspace\" :onrightclick \"../scripts/dispatch.sh 7 --move-workspace\" \
                    :class \"${C[7]}\" \"${S[7]} ₇\") \
            (button :onclick \"../scripts/dispatch.sh 8 --focus-workspace\" :onrightclick \"../scripts/dispatch.sh 8 --move-workspace\" \
                    :class \"${C[8]}\" \"${S[8]} ₈\") \
            (button :onclick \"../scripts/dispatch.sh 9 --focus-workspace\" :onrightclick \"../scripts/dispatch.sh 9 --move-workspace\" \
                    :class \"${C[9]}\" \"${S[9]} ₉\") \
        )\
    )"
}

update
socat -u UNIX-CONNECT:/tmp/hypr/"$HYPRLAND_INSTANCE_SIGNATURE"/.socket2.sock - | while read -r; do
    update
done


# echo \
# "(eventbox :onscroll \"echo {} | sed -e 's/up/-1/g' -e 's/down/+1/g' | xargs hyprctl dispatch workspace\" \
#     (box \
#         :class \"workspace\" \
#         :orientation \"h\" \
#         :space-evenly \"false\" \
#         (button :onclick \"scripts/dispatch.sh 1\" :class \"workspace focused\" \" ₁\") \
#         ;   (button :onclick \"scripts/dispatch.sh 2\" :class \"w0$o2$f2\" \"${ic[2]} ₂\") \
#         ;   (button :onclick \"scripts/dispatch.sh 3\" :class \"w0$o3$f3\" \"${ic[3]} ₃\") \
#         ;   (button :onclick \"scripts/dispatch.sh 4\" :class \"w0$o4$f4\" \"${ic[4]} ₄\") \
#         ;   (button :onclick \"scripts/dispatch.sh 5\" :class \"w0$o5$f5\" \"${ic[5]} ₅\") \
#         ;   (button :onclick \"scripts/dispatch.sh 6\" :class \"w0$o6$f6\" \"${ic[6]} ₆\") \
#         ;   (button :onclick \"scripts/dispatch.sh 7\" :class \"w0$o7$f7\" \"${ic[7]} ₇\") \
#         ;   (button :onclick \"scripts/dispatch.sh 8\" :class \"w0$o8$f8\" \"${ic[8]} ₈\") \
#         ;   (button :onclick \"scripts/dispatch.sh 9\" :class \"w0$o9$f9\" \"${ic[9]} ₉\") \
#     ) \
# )"


# #define icons for workspaces 1-9
# ic=(0         󰻧)

# workspaces() {

# 	unset -v \
#   o1 o2 o3 o4 o5 o6 o7 o8 o9 \
#   f1 f2 f3 f4 f5 f6 f7 f8 f9

# # Get occupied workspaces and remove workspace -99 aka scratchpad if it exists
# # a=\"$(hyprctl workspaces | grep ID | awk '{print $3}')\"
# # a=\"$(echo \"${a//-99/}\" | sed '/^[[:space:]]*$/d')\"
# ows=\"$(hyprctl workspaces -j | jq '.[] | del(select(.id == -99)) | .id')\"

# for num in $ows; do
# 	export o\"$num\"=\"$num\"
# done

# # Get Focused workspace for current monitor ID
# arg=\"$1\"
# num=\"$(hyprctl monitors -j | jq --argjson arg \"$arg\" '.[] | select(.id == $arg).activeWorkspace.id')\"
# export f\"$num\"=\"$num\"

# echo 	\"(eventbox :onscroll \\"echo {} | sed -e 's/up/-1/g' -e 's/down/+1/g' | xargs hyprctl dispatch workspace\\" \
#           (box	:class \\"workspace\\"	:orientation \\"h\\" :space-evenly \\"false\\" 	\
#               (button :onclick \\"scripts/dispatch.sh 1\\" :class \\"w0$o1$f1\\" \\"${ic[1]} ₁\\") \
#               (button :onclick \\"scripts/dispatch.sh 2\\" :class \\"w0$o2$f2\\" \\"${ic[2]} ₂\\") \
#               (button :onclick \\"scripts/dispatch.sh 3\\" :class \\"w0$o3$f3\\" \\"${ic[3]} ₃\\") \
#               (button :onclick \\"scripts/dispatch.sh 4\\" :class \\"w0$o4$f4\\" \\"${ic[4]} ₄\\") \
#               (button :onclick \\"scripts/dispatch.sh 5\\" :class \\"w0$o5$f5\\" \\"${ic[5]} ₅\\") \
#               (button :onclick \\"scripts/dispatch.sh 6\\" :class \\"w0$o6$f6\\" \\"${ic[6]} ₆\\") \
#               (button :onclick \\"scripts/dispatch.sh 7\\" :class \\"w0$o7$f7\\" \\"${ic[7]} ₇\\") \
#               (button :onclick \\"scripts/dispatch.sh 8\\" :class \\"w0$o8$f8\\" \\"${ic[8]} ₈\\") \
#               (button :onclick \\"scripts/dispatch.sh 9\\" :class \\"w0$o9$f9\\" \\"${ic[9]} ₉\\") \
#           )\
#         )\"
# }

# workspaces $1 
# socat -u UNIX-CONNECT:/tmp/hypr/\"$HYPRLAND_INSTANCE_SIGNATURE\"/.socket2.sock - | while read -r; do 
# workspaces $1
# done
