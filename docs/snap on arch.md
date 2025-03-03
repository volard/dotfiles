```bash
yay -S snapd
sudo systemctl unmask snapd.service
sudo systemctl enable --now snapd.service
sudo systemctl enable --now snapd.apparmor
# restart bash session
```