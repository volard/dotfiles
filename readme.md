# SSH keys
1. Create Encrypted SSH Keys
Assuming you have your SSH keys in a directory (e.g., ssh_keys/), you can encrypt the keys using the following command:

```bash
for key in ssh_keys/*; do
    ansible-vault encrypt "$key"
done
```

After running these commands, you will be prompted to enter a password to secure the files. The contents of these files will now be encrypted.

And then
```bash
ansible-playbook -i inventory/hosts copy_ssh_keys.yml --ask-vault-pass
# Or with a password file
ansible-playbook -i inventory/hosts copy_ssh_keys.yml --vault-password-file /path/to/vault_password_file
```


- Ssh keys secured with `Ansible Valut`
- Windows programs set up with `scoop`
- Linux apt distros packages installed with `nala`
- Configuration files uses Jinja2 to be flexible

# Credits
- https://github.com/Wintus/Ansible-WSL
- https://www.youtube.com/watch?v=gIDywsGBqf4&t=49s
- https://github.com/TechDufus/dotfiles
- https://github.com/stkrzysiak/windows-playbook-scoop
