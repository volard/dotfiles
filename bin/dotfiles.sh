#!/bin/bash
set -e;

# ansible project path 
DOTFILES_DIR="$HOME/dotfiles";
mkdir -p $CONFIG_DIR;
rm -r $CONFIG_DIR;

# Clone repository or pull
if ! [[ -d "$DOTFILES_DIR" ]]; then
  git clone "https://github.com/ALT-F4-LLC/dotfiles.git" "$DOTFILES_DIR";
else
  git -C "$DOTFILES_DIR" pull;
fi

cd "$DOTFILES_DIR";

# Determine distro
if [ -f /etc/os-release ]; then
    # Modern distributions use os-release file
    . /etc/os-release;
    distro=$ID;
    version=$VERSION_ID;
elif [ -f /etc/lsb-release ]; then
    # Older Ubuntu/Debian systems
    . /etc/lsb-release;
    distro=$DISTRIB_ID;
    version=$DISTRIB_RELEASE;
elif [ -f /etc/redhat-release ]; then
    # Older Red Hat based systems
    distro=$(cat /etc/redhat-release);
else
    # Fallback
    distro=$(uname -s);
    version=$(uname -r);
fi

echo "==== Configuring system ====";
echo "Distribution: $distro";
echo "Version: $version";

# Install Ansible
if ! [ -x "$(command -v ansible)" ]; then
    if [[ "${distro,,}" = "arch" ]]; then
        sudo pacman -S ansible --noconfirm
    else
        sudo apt-add-repository ppa:ansible/ansible;
        sudo apt-get update;
        sudo apt-get upgrade;
        sudo apt install python3-pip;
        pip3 install pywinrm;
        pip3 install pyvmomi;
        pip3 install ansible;
    fi
fi

# Update Galaxy
ansible-galaxy install -r requirements.yml

# Setup password if not exists
if ! [[ -f "$DOTFILES_DIR/vault-password.txt" ]]; then
    read -p "Please enter your Ansible Vault password: " ANSIBLE_PASSWORD;
    echo $ANSIBLE_PASSWORD >> $DOTFILES_DIR/vault-password.txt;
fi

# Run playbook
ansible-playbook --diff --vault-password-file "$DOTFILES_DIR/vault-password.txt" "$DOTFILES_DIR/main.yaml" "$@"