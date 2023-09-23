# Neovim configuration

Simple [Neovim](https://github.com/neovim) configuration, based on [NVChad](https://nvchad.com/)

## Install Neovim

Exemplary installation of [Neovim](https://github.com/neovim) on [Ubuntu](https://ubuntu.com/download):

```sh
cd ~/Downloads
wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
tar xzvf nvim-linux64.tar.gz

sudo mv nvim-linux64 /opt

echo "alias nvim=/opt/nvim-linux64/bin/nvim" >> ~/.bashrc
echo "alais v=nvim" >> ~/.bashrc

rm -rf nvim-linux64 nvim-linux64.tar.gz
```

Find stable release [here](https://github.com/neovim/neovim/releases/tag/stable).

## Dependencies

Ubuntu

```sh
sudo apt install npm python3-pip python3-venv npm zip

cd ~/Downloads
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Terminus.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/CascadiaCode.zip

unzip CascadiaCode.zip
unzip JetBrainsMono.zip
unzip Terminus.zip
rm *.zip

mkdir -p ~/.local/share/fonts
mv *.ttf ~/.local/share/fonts

fc-cache -fv
```

## Get configuration

Run the following script from the repository:

```sh
util/install_nvim.sh
# Dependencies are installed without question!
```

Run `nvim` and see the result.
