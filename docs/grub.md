1. **Update GRUB:**
   ```bash
   sudo grub2-mkconfig -o /boot/grub2/grub.cfg
   ```
   This command scans all your disks and partitions for bootable systems and updates the GRUB configuration file.

2. **Verify if another system is detected:**
   ```bash
   sudo grub2-editenv list
   ```
   Look for an entry that corresponds to new system installation.

5. **Reboot the system.**
   After rebooting, you should see new system listed in the GRUB menu.

**If it's still not detected:**

- **Check if the ESP is mounted:** Ensure that the EFI System Partition (ESP) where your bootloaders reside is mounted.
  ```bash
  sudo lsblk
  ```
  Identify the ESP partition (usually FAT32 and around 500MB) and mount it if needed.

- **Manually add an entry to GRUB:** If automatic detection fails, you can manually add an entry for new system in your `/boot/grub2/grub.cfg` file. However, this requires careful editing and should be done with caution. Refer to the GRUB documentation for the correct syntax.

- **Consider other boot managers:** If you continue to face difficulties with GRUB, you might consider using a different boot manager like rEFInd, which is known for its automatic OS detection capabilities.
