
source ~/.config/zsh/toni.zsh

source_file git_status.zsh
source_file prompt.zsh

add_plugin zsh-users/zsh-syntax-highlighting
{
}

add_plugin zsh-users/zsh-autosuggestions
{
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#BFBFBF,underline"  # bg=cyan,bold
    ZSH_AUTOSUGGEST_STRATEGY=(history completion)
    setopt APPEND_HISTORY
    setopt SHARE_HISTORY
    HISTFILE=$HOME/.zhistory
    SAVEHIST=1000
    HISTSIZE=999
    setopt HIST_EXPIRE_DUPS_FIRST
    setopt EXTENDED_HISTORY
    bindkey '^ ' autosuggest-accept
}

add_plugin jeffreytse/zsh-vi-mode
{
    ZVM_VI_INSERT_ESCAPE_BINDKEY='^['
    ZVM_VI_INSERT_ESCAPE_BINDKEY='jk'
}

add_plugin "zsh-users/zsh-history-substring-search"
{
    bindkey '^k' history-substring-search-up
    bindkey '^j' history-substring-search-down
}
