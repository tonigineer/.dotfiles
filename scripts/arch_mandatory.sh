#!/usr/bin/env bash

echo "Initial settings for Arch Linux"


echo -n ">> Install yay "
sudo pacman -S base-devel git vim
cd /opt
sudo git clone https://aur.archlinux.org/yay.git
sudo chown -R toni:wheel ./yay
cd yay
makepkg -si


echo -n ">> Configure pacman"
sudo sed -i 's\#Color\Color\g' /etc/pacman.conf
sudo sed -i 's/#ParallelDownloads = 5/ILoveCandy\nParallelDownloads = 10/g' /etc/pacman.conf


echo -n ">> Configure VIM"
echo "syntax on
filetype on
set noswapfile
set cursorcolumn
set number
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set textwidth=80
set nobackup
set hlsearch
set showmatch" > ~/.vimrc