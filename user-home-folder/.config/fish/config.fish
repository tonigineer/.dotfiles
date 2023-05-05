set fish_greeting ""

fish_vi_key_bindings

set -gx TERM xterm-256color

# theme
set -g theme_color_scheme terminal-dark
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always

# aliases
alias ls "ls -p -G"
alias la "ls -A"
alias ll "ls -l"
alias lla "ll -A"
alias g git
command -qv nvim && alias vim nvim
alias v vim

# if type -q tty-clock
#     alias clock="tty-clock -c -C 3"
# end

# if type -q cmatrix
#     alias matrix="cmatrix -ab -C red"
# end

# if type -q peaclock
#     alias clock_binary="peaclock --config ~/.peaclock/config/binary"
# end

# # these alias overwrite the default command!
# alias peaclock="peaclock --config-dir ~/.config/peaclock"
# alias cmatrix="cmatrix -srab"

set -gx EDITOR nvim

set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH

# exa alias if present
if type -q exa
    alias ls "exa --grid --color=auto --icons"
    alias la "exa -a --grid --color=auto --icons"
    alias ll "exa -l --icons --no-user --group-directories-first  --time-style long-iso -T -L2"
    alias lla "exa -la --icons --no-user --group-directories-first  --time-style long-iso -T -L2"
end

# ==================================
#             OH-MY-FISH
# ==================================

# THEME: kawasaki

# Enable the time to be displayed.
set -g theme_display_time yes
# Disable playing the user's current group.
set -g theme_display_group no
# Disable Git-awareness.
set -g theme_display_git yes
# Don't disable jobs indicator.
set -g theme_display_jobs yes
# Always display the jobs indicator, even if there are no jobs.
set -g theme_display_jobs_always no
# Hide the current directory read/write indicator.
set -g theme_display_rwt no
# Don't display the VirtualEnv prompt.
set -g theme_display_virtualent no

set -g theme_color_error F38BA8  # #F38BA8
set -g theme_color_superuser F38BA8  # #F38BA8
set -g theme_color_user 61AFEF # #B4BEFE
set -g theme_color_group 666666  # #666666
set -g theme_color_host E5C07B # #F9E2AF
set -g theme_color_separator 585B70  # #585B70
set -g theme_color_bracket 89B4FA  # #89B4FA
set -g theme_color_normal FAB387  # #FAB387
set -g theme_color_time 666666  # #666666
set -g theme_color_path F5E0DC  # #F5E0DC
set -g theme_color_prompt BAC2DE  # #BAC2DE
set -g theme_color_virtualenv F9E2AF  # #F9E2AF
set -g theme_color_status_prefix F9E2AF  # #F9E2AF
set -g theme_color_status_jobs A6E3A1  # #A6E3A1
set -g theme_color_status_rw A6ADC8  # #A6ADC8

set -g theme_prompt_char_normal ' ' # '$'
set -g theme_prompt_char_superuser ' ' # '#'
set -g theme_prompt_char "$theme_prompt_char_normal"

set -g theme_prompt_superuser_glyph \u2605
set -g theme_prompt_userhost_separator ':'

set -g theme_prompt_segment_separator_char ' '
set -g theme_prompt_segment_separator_color normal

set -g theme_prompt_status_jobs_char '%'
set -g theme_prompt_status_rw_char '.'
set -g theme_prompt_status_separator_char '/'

set -g theme_prompt_virtualenv_char_begin '('
set -g theme_prompt_virtualenv_char_end ')'
set -g theme_prompt_virtualenv_color_char_begin normal
set -g theme_prompt_virtualenv_color_char_end normal

set -g theme_display_time_format '+%H:%M'

set -g __fish_git_prompt_color_merging 89B4FA  # #89B4FA
set -g __fish_git_prompt_color_branch 89B4FA  # #89B4FA
set -g __fish_git_prompt_showcolorhints yes
set -g __fish_git_prompt_show_informative_status no
set -g __fish_git_prompt_char_stateseparator ''

set -g __fish_git_prompt_char_branch_begin '  '
set -g __fish_git_prompt_char_branch_end ' '
set -g __fish_git_prompt_color_branch_begin E06C75  # #E06C75
set -g __fish_git_prompt_color_branch_end F9E2AF  # #F9E2AF


# ==================================
#             AUTOSTART
# ==================================
neofetch
