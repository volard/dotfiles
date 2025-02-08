# Ansible driven dotfiles management

## Linux
with `curl`
```bash
bash -c "$(curl -fsSL https://gitlab.com/dotfiles30/comma_files/-/raw/main/bin/dotfiles.sh)"
```
or with `wget`
```bash
bash -c "$(wget -qO- https://gitlab.com/dotfiles30/comma_files/-/raw/main/bin/dotfiles.sh)"
```

## Windows

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
iex (iwr -Uri "https://gitlab.com/dotfiles30/comma_files/-/raw/main/bin/dotfiles.ps1" -UseBasicParsing).Content
```

## Structure

Each role **installs and configures** a program. If program doesn't need to be configured, it would be installed with help of `programs` role.

```bash
roles/                      # setup and install programs
roles/common_tasks/         # tasks, that can be used across roles
roles/name/files/           # config files: templates and static
roles/name/molecule/        # test role
vars/                       # role-specific variables
group_vars/                 # os-specific variables
files/                      # common static files
pre_tasks/                  # preliminary tasks to setup an OS
molecule/                   # test playbook
inventory.yml               # define hosts and groups
```

## SSH keys

SSH keys as well as sensitive variables encoded with [`Ansible Valut`](https://docs.ansible.com/ansible/latest/vault_guide/index.html)

## Some references

- [Wintus' Ansible-WSL](https://github.com/Wintus/Ansible-WSL)
- [TechDufus config - YT](https://www.youtube.com/watch?v=gIDywsGBqf4&t=49s)
- [TechDufus config - GitHub](https://github.com/TechDufus/dotfiles)
- [Windows playbook scoop](https://github.com/stkrzysiak/windows-playbook-scoop)
- [ALT-F4-LLC's dotfiles](https://github.com/ALT-F4-LLC/dotfiles)


## Tested roles
On Kubuntu:
- programs
- bash
- lazy_neovim
- bash
- oh-my-posh
- linux_setup
- alacritty
- docker
