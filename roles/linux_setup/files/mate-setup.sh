# setup dconf-editor
sudo nala install dconf-editor -y

# remove silly startup drums sound via renaming sound file
cd /usr/share/sounds/arctica-greeter/stereo
sudo mv system-ready.ogg system-ready-silly-sound.ogg

# setup i3 with mate
dconf write /org/mate/desktop/session/required-components/windowmanager "'i3'"
dconf write /org/mate/desktop/background/show-desktop-icons false
# TODO also this list that I stated in readme
dconf write /org/mate/desktop/session/required-components/ "'i3'"
