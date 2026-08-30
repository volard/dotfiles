# Ansible + chezmoi dotfiles management

Ansible bootstraps packages, services, system config, and vaulted secrets.
[`chezmoi`](https://www.chezmoi.io/) manages user config files from [`chezmoi`](chezmoi).

## Linux

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/volard/dotfiles/refs/heads/main/chezmoi/dot_local/bin/executable_dotfiles)"
# or
bash -c "$(wget -qO-  https://raw.githubusercontent.com/volard/dotfiles/refs/heads/main/chezmoi/dot_local/bin/executable_dotfiles)"
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

