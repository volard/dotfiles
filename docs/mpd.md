# MPD: user vs system service

## Rule

Run one `mpd` unless you intentionally want multiple instances with different ports/configs.

Two common modes:

- User service: `systemctl --user ...`
- System service: `systemctl ...`

If both start with default config, both want port `6600` and one fails.

## My setup

Keep user `mpd`.

- User service: enabled, running
- System service: masked

## Check state

```bash
systemctl --user status mpd.service
systemctl status mpd.service mpd.socket
ss -ltnp | rg ':6600\b'
```

Expected:

- user `mpd.service`: `active (running)`
- system `mpd.service` / `mpd.socket`: `masked`
- port `6600`: owned by one `mpd` process

## Disable vs mask

`disable`:

- removes autostart symlinks
- unit can still be started manually or by dependency

`mask`:

- creates symlink to `/dev/null`
- unit cannot start at all until unmasked

## Commands

Keep only user MPD:

```bash
sudo systemctl disable --now mpd.service mpd.socket
sudo systemctl mask mpd.service mpd.socket
sudo systemctl reset-failed mpd.service
systemctl --user enable --now mpd.service
```

See mask:

```bash
ls -l /etc/systemd/system/mpd.service /etc/systemd/system/mpd.socket
```

Expected:

```text
/etc/systemd/system/mpd.service -> /dev/null
/etc/systemd/system/mpd.socket -> /dev/null
```

Remove mask later:

```bash
sudo systemctl unmask mpd.service mpd.socket
```

Switch to system-wide MPD instead:

```bash
systemctl --user disable --now mpd.service
sudo systemctl unmask mpd.service mpd.socket
sudo systemctl enable --now mpd.service
```

## Why both exist

Package ships both unit types. That does not mean both should run.

Use user service for:

- personal desktop/laptop
- local session-owned music daemon

Use system service for:

- headless box
- shared machine
- daemon should run before login
