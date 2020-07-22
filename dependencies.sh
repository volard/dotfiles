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
    flameshot \
    numlockx \
    gnome-shell-pomodoro

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


# install safe eyes
sudo apt-get install gir1.2-appindicator3-0.1 gir1.2-notify-0.7 python3-psutil python3-xlib xprintidle python3-pip
sudo pip3 install safeeyes
sudo update-icon-caches /usr/share/icons/hicolor


#install dunst 
sudo apt install libnotify-dev
apt install libdbus-1-dev libx11-dev libxinerama-dev libxrandr-dev libxss-dev libglib2.0-dev libpango1.0-dev libgtk2.0-dev libxdg-basedir-dev

cd ~/Downloads
$ git clone https://github.com/dunst-project/dunst.git
$ cd dunst
$ make -j5
$ sudo make install


#install conky-spotify-status https://github.com/Madh93/conky-spotify
wget -O conky-spotify https://codeload.github.com/Madh93/conky-spotify/zip/master
unzip conky-spotify
mv conky-spotify-master ~/.conky/conky-spotify



#install spotify 
curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update && sudo apt-get install spotify-client
sudo apt-get install texlive-full


# playerctl for music
#https://github.com/acrisci/playerctl/releases
    if hash playerctl 2>/dev/null; then
    	echo "playerctl already installed"
    else
        wget https://github.com/acrisci/playerctl/releases/download/v0.5.0/playerctl-0.5.0_amd64.deb -O /tmp/playerctl
		sudo dpkg -i /tmp/playerctl
    fi

#install zscroll
git clone https://github.com/noctuid/zscroll
cd zscroll
sudo python3 setup.py install
