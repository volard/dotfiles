# vim: filetype=ps1

# In case u have bad installation like "bad hash checking or smth": scoop cache rm git; scoop uninstall git; scoop install git

$programs = @(

);
# ------ MISC ------
# electerm,
# wingetui,
# mcomix,
# kdenlive,
# digicam,
# flameshot,
# autohotkey,
# gittyup,
# obs-studio,
# czkawka,
# zotero,

# Versatile, classic, complete name server software.
# bind,

# The simple countdown timer for Windows
# hourglass,
# okular,
# firefox,
# paint.net,
# fork,
# tor-browser,
# thunderbird,
# caesium-image-compressor,
# virtualbox-with-extension-pack-np,
# calibre,
# blender,

# A high-precision scientific calculator featuring a fast,
# keyboard-driven user interface.
# speedcrunch,

# deepl;


sudo scoop install $programs;


# TODO https://developer.hashicorp.com/vagrant
# TODO use peaces of this https://github.com/cocreators-ee/aperture-control with chezmoi
#https://getcoldturkey.com/features/
# TO get more https://www.softpedia.com


# ---------------------------
# Setup node & npm
# ---------------------------
if (Get-Command "node" -errorAction SilentlyContinue){}
else {
  sudo nvm install latest
  sudo nvm use latest
}
