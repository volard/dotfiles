#!/bin/bash

GREEN='\033[0;32m'
NC='\033[0m' # No Color

fontsDirectory=~/.local/share/fonts/
mkdir -p $fontsDirectory

# Install JetBrains Mono Nerd font
if ! [[ $(fc-list | grep "JetBrainsMono Nerd Font") ]]; then
  echo -e "Installing ${GREEN}JetBrainsMono Nerd ${NC}font..."
  mkdir "$fontsDirectory"JetBrainsMono
  tar xf ~/.local/share/chezmoi/fonts/JetBrainsMono.tar.gz --directory="$fontsDirectory"JetBrainsMono
fi

# Install Font Awesome Desktop font
if ! [[ $(fc-list | grep "Awesome") ]]; then
  echo -e "Installing ${GREEN}Font Awesome 6 ${NC}font..."
  mkdir "$fontsDirectory"FontAwesome6
  tar xf ~/.local/share/chezmoi/fonts/FontAwesome6.tar.gz --directory="$fontsDirectory"FontAwesome6
fi

# Install Feather font
if ! [[ $(fc-list | grep "Feather") ]]; then
  echo -e "Installing ${GREEN}Feather ${NC}font..."
  mkdir "$fontsDirectory"Feather
  tar xf ~/.local/share/chezmoi/fonts/Feather.tar.gz --directory="$fontsDirectory"Feather
fi

# Install Material Icons font
if ! [[ $(fc-list | grep "Material") ]]; then
  echo -e "Installing ${GREEN}Materaial Icons ${NC}font..."
  mkdir "$fontsDirectory"MaterialIcons
  tar xf ~/.local/share/chezmoi/fonts/MaterialIcons.tar.gz --directory="$fontsDirectory"MaterialIcons
fi

fc-cache -f
