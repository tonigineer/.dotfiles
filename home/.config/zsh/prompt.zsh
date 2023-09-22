PROMPT='%239F%D{%H:%M:%S}%f '
PROMPT+='%39F%n%8F:%222F%m%f '
PROMPT+='%188F%$((-${#vcs_info_msg_0_}-1))<…<%~%<<%f '  # working directory
PROMPT+='${vcs_info_msg_0_:+ %210F%f %39F$vcs_info_msg_0_}'
PROMPT+=$'\n'
PROMPT+='%F{%(?.15.210)}❯ %f '  # %/# (normal/root); green/red (ok/error)
