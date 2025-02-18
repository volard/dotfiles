# Ansible driven dotfiles management

## Linux
with `curl`
```bash
bash -c "$(curl -fsSL https://gitlab.com/dotfiles30/comma_files/-/raw/main/bin/dotfiles)"
```
or with `wget`
```bash
bash -c "$(wget -qO- https://gitlab.com/dotfiles30/comma_files/-/raw/main/bin/dotfiles)"
```

## Windows

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
iex (iwr -Uri "https://gitlab.com/dotfiles30/comma_files/-/raw/main/bin/dotfiles.ps1" -UseBasicParsing).Content
```

Binary `dotfiles` ([see](bin/dotfiles)) is in PATH after initial setup (make sure to reopen Bash).

Run specified roles only
```bash
dotfiles -t separated, roles
```

## Structure

Each role **installs and configures** a program. If program doesn't need to be configured, it would be installed with help of `programs` ([see](roles/programs/tasks)) role.

```bash
roles/common_tasks/         # tasks, that can be used across roles
roles/name/molecule/        # test a role
files/                      # common static files
pre_tasks/                  # preliminary tasks to setup an OS
molecule/                   # test playbook
```

By default playbook would run all available roles (except [common_tasks](roles/common_tasks/tasks)). The `roles_to_exclude` list defined in [all.yml](groups/all.yml) provides the way to exclude unwanted roles. `default_roles` in the [all.yml](groups/all.yml) updates automagically everytime to stay in sync with the roles subdirectories. It's done by [sync_roles.py](bin/sync_roles.py), that also automates usage of [TechDufus](https://github.com/TechDufus/)'s [main.yml](https://github.com/TechDufus/).

## SSH keys

SSH keys as well as sensitive variables encoded with [`Ansible Valut`](https://docs.ansible.com/ansible/latest/vault_guide/index.html)

```bash
# encrypt files
ansible-vault encrypt ./roles/ssh/files/*

# encrypt variable
ansible-vault encrypt_string 'name' --name 'username' | wl-copy
```

## Credits

- [Wintus Ansible-WSL](https://github.com/Wintus/Ansible-WSL)
- [TechDufus config - YT](https://www.youtube.com/watch?v=gIDywsGBqf4&t=49s)
- [TechDufus config - GitHub](https://github.com/TechDufus/dotfiles)
- [Windows playbook scoop](https://github.com/stkrzysiak/windows-playbook-scoop)
- [ALT-F4-LLC's dotfiles](https://github.com/ALT-F4-LLC/dotfiles)
