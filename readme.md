# Ansible driven dotfiles management

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

Each role **installs and configures** a program. If program doesn't need to be configured, it's listed in `packages` list.


## SSH keys
SSH keys secured with [`Ansible Valut`](https://docs.ansible.com/ansible/latest/vault_guide/index.html)

1. Create Encrypted SSH Keys

```bash
for key in ssh_keys/*; do
    ansible-vault encrypt "$key"
done
```

## Credits
- https://github.com/Wintus/Ansible-WSL
- https://www.youtube.com/watch?v=gIDywsGBqf4&t=49s
- https://github.com/TechDufus/dotfiles
- https://github.com/stkrzysiak/windows-playbook-scoop
