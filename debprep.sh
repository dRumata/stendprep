#!/bin/bash
echo "Установка ПО deb"
sudo apt install git tmux mc ufw curl ripgrep lua5.4 gcc -y
sudo nmcli con mod "Wired connection 1" con-name labnet

tee /home/sa/.tmux.conf << _EOF_
set -g mouse on
set -g status-style bg=black
set -g window-status-current-style bg=yellow,fg=black,bold
set -g status-right '#(curl -s wttr.in/Hamburg:Москва:Челябинск:Иркутск:Владивосток\?format\="%%l:+%%c%%20%%t%%60%%w&period=20") ...'
#set -g status-right '#(curl "wttr.in/?format=3") '
set -g default-terminal "tmux-256color"

set -g status-interval 10
set -g status-left-length 30
set -g status-left '#[fg=green]#(cut -d " " -f 1-3 /proc/loadavg)#[default] #[fg=cyan]%H:%M#[default] '
_EOF_


mkdir -p ~/.local/share/fonts
cd /tmp/
wget https://github.com/neovim/neovim-releases/releases/download/nightly/nvim-linux64.deb
sudo apt install ./nvim-linux64.deb
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/MartianMono.zip && unzip MartianMono.zip -d ~/.local/share/fonts/
cd
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
sudo cp ~/.config/nvim /root/.config/ -R
echo "alias vim=nvim"|tee -a ~/.bashrc
echo "--------------------------------------"
echo "ВНИМАНИЕ!!! При первом запуске nvim или vim будет произведена инициализация и настройка плагинов."
echo "--------------------------------------"