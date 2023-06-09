# Neovim configuration

## Install dependencies

```sh
sudo pacman -S npm fd ripgrep unzip
```

## Key mapping

### Cheat sheet

Shortcut | Function
--- | ---
<kbd>CTRL,w</kbd> | delete word before cursor

### Old habits

Shortcut | Function
--- | ---
<kbd>CTRL,s</kbd> | save file
<kbd>CTRL,a</kbd> | select all
<kbd>CTRL,z</kbd> | undo

### General

Shortcut | Function
--- | ---
<kbd>CTRL,n</kbd> | next item (telescope, LSP)
<kbd>CTRL,p</kbd> | prev item (telescope, LSP)

### Telescope

Shortcut | Function
--- | ---
<kbd>LEADER,p,f</kbd> | Find files
<kbd>LEADER,p,g</kbd> | Find git files
<kbd>LEADER,p,s</kbd> | Find string in files

### Diagnostics

Shortcut | Function
--- | ---
<kbd>LEADER,d,d</kbd> | Show diagnostic in telescope window
<kbd>LEADER,d,o</kbd> | show floating window of diagnostic
<kbd>LEADER,d,[</kbd> | goto prev diagnostic
<kbd>LEADER,d,]</kbd> | goto next diagnostic

### Fugitive (Git integration)

Shortcut | Function
--- | ---
<kbd>LEADER,g,s</kbd> | Show git status
