# NTFS
- Needed packages (google them, I forget)
- ntfsfix can perform light fixing procedures
- to fully restore NTFS windows custom usb installer needed with access to the command line (or open windowd recovery mode with usb and find cmd here, but idk how exactly now)

# List disks
```bash
lsblk
sudo fdisk -l
```

# Formatting
```bash
sudo mkfs -t ext4 /dev/sda1
```

# Access
After formatting info about permissions is gone as well
```bash
sudo chown -R user:user /run/media/user/driveA/
```
