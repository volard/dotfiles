# Ansible driven dotfiles management

## Set up
```bash
dotfiles_path=~/dotfiles

mkdir -p $dotfiles_path;
rm -r $dotfiles_path;

git clone https://gitlab.com/dotfiles30/comma_files.git $dotfiles_path;
cd $dotfiles_path;
vi vault-password.txt
```

```bash
ansible-galaxy collection install -r requirements.yml
ansible-playbook main.yml --vaul-password-file /vault-password.txt
```

```bash
# git@gitlab.com:dotfiles30/comma_files.git
v .git/config
```

## Structure
Each role **installs and configures** a program. If program doesn't need to be configured, it's listed in `packages` list.

```bash
roles/              # setup and install programs
roles/common_tasks/ # tasks, that can be used across roles
roles/files/        # config files: templates and static
vars/               # role-specific variables
group_vars/         # os-specific variables
files/              # common static files
pre_tasks/          # preliminary tasks to setup an OS
archive/            # old stuff, not used by Ansible 
scripts/            # some useful things, not used by Ansible
```


## SSH keys
SSH keys as well as sensitive variables encoded with [`Ansible Valut`](https://docs.ansible.com/ansible/latest/vault_guide/index.html)


### Some references
- https://github.com/Wintus/Ansible-WSL
- https://www.youtube.com/watch?v=gIDywsGBqf4&t=49s
- https://github.com/TechDufus/dotfiles
- https://github.com/stkrzysiak/windows-playbook-scoop
