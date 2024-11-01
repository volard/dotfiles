# Ansible driven dotfiles management
- Windows programs set up with `scoop`
- Linux apt distros packages installed with `nala`
- Configuration files uses Jinja2 to be flexible

# SSH keys
SSH keys secured with `Ansible Valut`

1. Create Encrypted SSH Keys
Assuming you have your SSH keys in a directory (e.g., ssh_keys/), you can encrypt the keys like that:

```bash
for key in ssh_keys/*; do
    ansible-vault encrypt "$key"
done
```

After running these commands, you will be prompted to enter a password.

2. And then
```bash
ansible-playbook -i inventory/hosts copy_ssh_keys.yml --ask-vault-pass
# Or with a password file
ansible-playbook -i inventory/hosts copy_ssh_keys.yml --vault-password-file /path/to/vault_password_file
```


# Credits
- https://github.com/Wintus/Ansible-WSL
- https://www.youtube.com/watch?v=gIDywsGBqf4&t=49s
- https://github.com/TechDufus/dotfiles
- https://github.com/stkrzysiak/windows-playbook-scoop
