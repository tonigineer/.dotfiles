ZSH_DOT_DIR=~/.config/zsh

function source_file() {

    if [ -f "$ZSH_DOT_DIR/$1" ]; then
        source "$ZSH_DOT_DIR/$1"
    fi
}

function add_plugin() {
    PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
    if [ ! -d "$ZSH_DOT_DIR/plugins/$PLUGIN_NAME" ]; then
        git clone "https://github.com/$1.git" "$ZSH_DOT_DIR/plugins/$PLUGIN_NAME"
    fi

    source_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh"
    source_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.zsh"
}

