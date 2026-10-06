# NTFS
> Just don't use that crap.

- Needed packages: `ntfs-3g`
- `ntfsfix` can perform light fixing procedures
- to fully restore NTFS windows custom usb installer needed with access to the command line (or open windowd recovery mode with usb and find cmd here, but idk how exactly now)

# List disks
```bash
lsblk
sudo fdisk -l # all drives and their partitions
sudo blkid # information about available block devices
```

# Automount

For USB ext4 drive at `/mnt/data`. Use UUID, not `/dev/sda1`: device names can change after reconnect.

Choose one setup: `/etc/fstab` or native systemd units. Automount mounts on access, not immediately on reconnect.

## `/etc/fstab`

Replace existing `/mnt/data` entry:

```fstab
UUID=5f057644-4e2d-4046-994f-7a4d654d769f /mnt/data ext4 nofail,x-systemd.automount,x-systemd.device-bound,x-systemd.device-timeout=10s 0 2
```

- `nofail`: boot continues without drive.
- `x-systemd.automount`: access to `/mnt/data` triggers mount.
- `x-systemd.device-bound`: stop mount when device disappears.
- `x-systemd.device-timeout=10s`: wait up to 10 seconds for missing device.

No other configuration files needed. Systemd generates mount and automount units.

Close apps using drive. Unmount must succeed before continuing:

```bash
unmount-data.sh
```

Then activate automount:

```bash
sudo systemctl daemon-reload
sudo systemctl start mnt-data.automount
ls /mnt/data
```

## Alternative: native systemd units

Remove or comment existing `/mnt/data` entry in `/etc/fstab` first. Do not configure both methods.

Create `/etc/systemd/system/mnt-data.mount`:

```ini
[Unit]
Description=Data drive
BindsTo=dev-disk-by\x2duuid-5f057644\x2d4e2d\x2d4046\x2d994f\x2d7a4d654d769f.device
After=dev-disk-by\x2duuid-5f057644\x2d4e2d\x2d4046\x2d994f\x2d7a4d654d769f.device
Requires=systemd-fsck@dev-disk-by\x2duuid-5f057644\x2d4e2d\x2d4046\x2d994f\x2d7a4d654d769f.service
After=systemd-fsck@dev-disk-by\x2duuid-5f057644\x2d4e2d\x2d4046\x2d994f\x2d7a4d654d769f.service

[Mount]
What=/dev/disk/by-uuid/5f057644-4e2d-4046-994f-7a4d654d769f
Where=/mnt/data
Type=ext4
Options=defaults
```

Create `/etc/systemd/system/mnt-data.automount`:

```ini
[Unit]
Description=Automount data drive

[Automount]
Where=/mnt/data

[Install]
WantedBy=multi-user.target
```

Unit names must match mount path: `/mnt/data` becomes `mnt-data`. For another UUID, derive device name with:

```bash
systemd-escape --path --suffix=device /dev/disk/by-uuid/5f057644-4e2d-4046-994f-7a4d654d769f
```

Close apps using drive. Run `unmount-data.sh`; continue only after successful unmount:

```bash
sudo mkdir -p /mnt/data
sudo systemctl daemon-reload
sudo systemctl enable --now mnt-data.automount
ls /mnt/data
```

Enable only automount unit. Native setup uses systemd's default device wait timeout; `fstab` setup above limits wait to 10 seconds.

## Safe unplugging

With automount active, accessing `/mnt/data` after manual unmount mounts drive again.
Close apps using drive, then stop automount before unplugging:

```bash
sudo systemctl stop mnt-data.automount
unmount-data.sh
```

Unplug only after successful unmount. After reconnect, restore automount:

```bash
sudo systemctl start mnt-data.automount
ls /mnt/data
```

## Sleep disconnects

Observed: USB disconnect after resume, ext4 journal abort, repeated I/O errors despite USB reconnect.
Automount handles mounting; it cannot prevent USB disconnects or recover old file handles.
Device-bound mount stops when drive disappears, but busy apps can prevent clean unmount.

- Test direct laptop port, another cable, or another enclosure.
- USB runtime power control already read `on` during investigation; disabling autosuspend alone may not help.
- Back up accessible files after journal errors. Check filesystem only while unmounted.
- Do not automate interactive `unmount-data.sh` as sleep hook: it prompts and can terminate apps.

Inspect mount state and kernel errors:

```bash
systemctl status mnt-data.automount mnt-data.mount
findmnt /mnt/data
journalctl -b -k --no-pager | rg 'USB disconnect|EXT4-fs|I/O error|suspend|resume'
```

[Systemd mount options](https://www.freedesktop.org/software/systemd/man/latest/systemd.mount.html)

# Formatting
```bash
sudo mkfs -t ext4 /dev/sda1
```

# Access
After formatting info about permissions is gone as well
```bash
sudo chown -R user:user /run/media/user/driveA/
```
