sudo pacman -S vivaldi blueman
yay -S hiddify
sudo pacman -S --needed bluez bluez-utils
sudo systemctl enable bluetooth
sudo systemctl start bluetooth


sudo pacman -S docker docker-compose
sudo usermod -aG docker $USER
newgrp docker
sudo systemctl enable docker
sudo systemctl start docker
yay -S lazydocker

sudo pacman -S lazygit neovim lf neofetch eza bat git-delta ansible lf zoxide tldr baobab
