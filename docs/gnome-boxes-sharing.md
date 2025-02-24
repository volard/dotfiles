- https://discussion.fedoraproject.org/t/gnome-boxes-does-not-show-shared-folders-menu/63839/3
- https://alexandruvisarion.wordpress.com/2017/06/15/gnome-boxes-introducing-shared-folders/
- https://itsfoss.com/share-files-gnome-boxes/
- https://itsfoss.community/t/gnome-boxes-communication-between-guest-and-host/11807/7

# Ubuntu
1.
```
sudo apt install spice-webdavd spice-client-gtk spice-vdagent
systemctl reboot
```
2. Check it's running
```
ps ax | grep spice
```
3. Share directory through box's preferences
4. Access Spice client folder in network in file manager
5. If it's not accessible, locate it manually via `dav://localhost:9843/`

# Windows
1. Download and install SPICE Guest Tools for Windows Guest system from https://www.spice-space.org/download.html
2. Download ans install Spice WebDAV daemon from the same place
3. Reload Shindows
4. Share directory through box's preferences
5. Access Spice client folder in network in file manager (it was DavWWWRoot under some localhost@8546)
