#!/bin/bash


# volume icon
# gxkb
# xkb-switch

sudo apt-get update

sudo apt-get install -y autoconf
sudo apt-get install -y automake
sudo apt-get install -y build-essential
sudo apt-get install -y libtool
sudo apt-get isntall -y sukless-tools

sudo apt-get install -y xutils-dev \
    xcb \
    libxcb-composite0-dev 

sudo apt-get install -y libxcb1-dev \
    libxcb-keysyms1-dev \
    libpango1.0-dev \
    libxcb-util0-dev \
    libxcb-icccm4-dev \
    libyajl-dev  

sudo apt-get install -y libstartup-notification0-dev \
    libxcb-randr0-dev \
    libev-dev \
    libxcb-cursor-dev \
    libxcb-xinerama0-dev \
    libxcb-xkb-dev \
    libxkbcommon-dev \
    libxkbcommon-x11-dev \
    conkey-all \
    dmenu \
    i3status i3lock \
    lxappearance \
    feh \
    lsb-release \
    unclutter \
    breeze-cursor-theme \
    neofetch \
    i3blocks \
    arandr \
    cmake \
    cmake-data \
    compton \
    flameshot

#installing i3-auto-layout
sudo apt remove --auto-remove --purge rust-gdb rustc libstd-rust-1.24 libstd-rust-1.28 libstd-rust-dev
echo "Now you're must to edit curl\'s installation to get nightly version!" 
echo "===================================="
echo "Type something to continue..."
read input
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
echo "$HOME/.cargo/bin" >> $HOME/.bashrc
source $HOME/.bashrc
cargo install --git https://github.com/chmln/i3-auto-layout


# installing of i3 gapps
rm -rf /tmp/Airblader

git clone https://github.com/Airblader/i3.git /tmp/Airblader
cd /tmp/Airblader

# compile & install
autoreconf --force --install
rm -rf build/
mkdir -p build && cd build/

# Disabling sanitizers is important for release versions!
# The prefix and sysconfdir are, obviously, dependent on the distribution.
../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers

make && sudo make install

rm -rf /tmp/Airblader
