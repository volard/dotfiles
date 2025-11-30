# Ansible driven dotfiles management

## Linux
```bash
bash -c "$(curl -fsSL https://gitlab.com/dotfiles30/comma_files/-/raw/main/bin/dotfiles)"
# or
bash -c "$(wget -qO- https://gitlab.com/dotfiles30/comma_files/-/raw/main/bin/dotfiles)"
```

## Windows

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
iex (iwr -Uri "https://gitlab.com/dotfiles30/comma_files/-/raw/main/bin/dotfiles.ps1" -UseBasicParsing).Content
```

Binary [`dotfiles`](bin/dotfiles) is in PATH after initial setup.

Run specified roles only
```bash
dotfiles -t separated,roles,no,spaces
```

## SSH keys

SSH keys as well as sensitive variables encoded with [`Ansible Valut`](https://docs.ansible.com/ansible/latest/vault_guide/index.html)

```bash
# refresh SSH files from ~/.ssh and re-encrypt them
just refresh-ssh-files

# encrypt files
ansible-vault encrypt ./roles/ssh/files/*

# encrypt variable (wayland)
ansible-vault encrypt_string 'name' --name 'username' | wl-copy
```

## Credits

- [Wintus Ansible-WSL](https://github.com/Wintus/Ansible-WSL)
- [TechDufus config - YT](https://www.youtube.com/watch?v=gIDywsGBqf4&t=49s)
- [TechDufus config - GitHub](https://github.com/TechDufus/dotfiles)
- [Windows playbook scoop](https://github.com/stkrzysiak/windows-playbook-scoop)
- [ALT-F4-LLC's dotfiles](https://github.com/ALT-F4-LLC/dotfiles)
