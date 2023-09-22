set fish_greeting ""

if status --is-login
    if test (tty) = /dev/tty1
        exec ~/.local/bin/hyprland -- -keeptty # or start sway or whatever
    end
end

fish_vi_key_bindings

set -gx TERM xterm-256color

set -g fish_autosuggestion_enabled 1
bind -M insert \cf accept-autosuggestion

# theme
set -g theme_color_scheme terminal-dark
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always

set -gx EDITOR nvim

set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH

# ==================================
#             ALIASES
# ==================================

# exa alias if present
if type -q exa
    alias ls "exa --grid --color=auto --icons"
    alias la "exa -a --grid --color=auto --icons"
    alias ll "exa -l --icons --no-user --group-directories-first  --time-style long-iso -T -L2"
    alias lla "exa -la --icons --no-user --group-directories-first  --time-style long-iso -T -L2"
end

if type -q nvim
    alias v=nvim
else
    alias v=vim
end

if type -q tty-clock
    alias clock="tty-clock -c -C 3"
end

if type -q cmatrix
    alias matrix="cmatrix -ab -C red"
end


# ==================================
#             Prompt
# ==================================

# THEME: kawasaki
set -g theme_display_time yes
set -g theme_display_time_format '+%H:%M'
set -g theme_display_group no
set -g theme_display_git yes
set -g theme_display_jobs yes
set -g theme_display_jobs_always no
set -g theme_display_rwt no
set -g theme_display_virtualent no

set -g theme_color_normal FAB387                        #FAB387
set -g theme_color_error F38BA8                         #F38BA8

set -g theme_color_superuser F38BA8                     #F38BA8
set -g theme_color_separator 585B70                     #585B70
set -g theme_color_bracket 89B4FA                       #89B4FA
set -g theme_color_prompt BAC2DE                        #BAC2DE
# set -g theme_color_virtualenv F9E2AF                    #F9E2AF
# set -g theme_color_status_prefix F9E2AF                 #F9E2AF
# set -g theme_color_status_jobs A6E3A1                   #A6E3A1

set -g theme_prompt_segment_separator_char ' '
set -g theme_prompt_segment_separator_color normal

set -g theme_prompt_char_normal '❯ '
set -g theme_prompt_char_superuser ' '
set -g theme_prompt_char "$theme_prompt_char_normal"

set -g theme_color_time 666666                          #666666

set -g theme_color_user 61AFEF                          #B4BEFE
set -g theme_color_group 666666                         #666666
set -g theme_color_host E5C07B                          #E5C07B
set -g theme_prompt_userhost_separator ':'

set -g theme_color_path F5E0DC                          #F5E0DC

# Git status
set -g __fish_git_prompt_char_branch_begin '⌜ '
set -g __fish_git_prompt_color_branch_begin 585B70      #585B70

set -g __fish_git_prompt_color_merging 89B4FA           #89B4FA
set -g __fish_git_prompt_color_branch 89B4FA            #89B4FA

set -g __fish_git_prompt_char_upstream_behind ' ↓'
set -g __fish_git_prompt_char_upstream_ahead ' ↑'

set -g __fish_git_prompt_char_stateseparator ' '

set -g __fish_git_prompt_showcolorhints yes
set -g __fish_git_prompt_show_informative_status yes

set -g __fish_git_prompt_char_cleanstate '✔'
set -g __fish_git_prompt_color_cleanstate A6E3A1        #A6E3A1

set -g __fish_git_prompt_color_dirtystate F38BA8        #F38BA8
set -g __fish_git_prompt_char_dirtystate 'M'

set -g __fish_git_prompt_char_invalidstate 'I'
set -g __fish_git_prompt_color_invalidstate F38BA8

set -g __fish_git_prompt_char_stagedstate 'S'
set -g __fish_git_prompt_color_stagedstate A6E3A1       #A6E3A1

set -g __fish_git_prompt_char_untrackedfiles 'U'
set -g __fish_git_prompt_color_untrackedfiles F9E2AF    #F9E2AF

set -g __fish_git_prompt_char_branch_end '⌟'
set -g __fish_git_prompt_color_branch_end 585B70        #585B70

# Folder rights
set -g theme_prompt_status_jobs_char '%'
set -g theme_prompt_status_rw_char '󰭔'
set -g theme_prompt_status_separator_char ' /'
set -g theme_color_status_rw A6ADC8                     #A6ADC8

# ==================================
#             AUTOSTART
# ==================================
neofetch
