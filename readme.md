# Ansible driven dotfiles management

## Install

### Linux

```bash
bash -c "$(curl -fsSL https://gitlab.com/dotfiles30/comma_files/-/raw/main/bin/dotfiles.sh)"
```

### Windows

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
iex (iwr -Uri "https://gitlab.com/dotfiles30/comma_files/-/raw/main/bin/dotfiles.sh" -UseBasicParsing).Content
```

## Structure

Each role **installs and configures** a program. If program doesn't need to be configured, it is gonna be installed in `programs` role.

```bash
roles/              # setup and install programs
roles/common_tasks/ # tasks, that can be used across roles
roles/name/files/   # config files: templates and static
vars/               # role-specific variables
group_vars/         # os-specific variables
files/              # common static files
pre_tasks/          # preliminary tasks to setup an OS
archive/            # old stuff, not used by Ansible
molecule/           # test playbook
inventory.yml       # define hosts and groups
```

## SSH keys

SSH keys as well as sensitive variables encoded with [`Ansible Valut`](https://docs.ansible.com/ansible/latest/vault_guide/index.html)

### Some references

- https://github.com/Wintus/Ansible-WSL
- https://www.youtube.com/watch?v=gIDywsGBqf4&t=49s
- https://github.com/TechDufus/dotfiles
- https://github.com/stkrzysiak/windows-playbook-scoop
- https://github.com/ALT-F4-LLC/dotfiles
