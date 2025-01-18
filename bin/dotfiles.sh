#!/bin/bash

set -e

# paths
DOTFILES_DIR="${HOME}/dotfiles"
PASSWORD_FILE_PATH="${DOTFILES_DIR}/vault-password.txt"

read -s -p "Enter vault password: " PASSWORD
echo

# Clone repository or pull
if ! [[ -d ${DOTFILES_DIR} ]]; then
	git clone "https://gitlab.com/dotfiles30/comma_files.git" "${DOTFILES_DIR}"
else
        if ! [[ -d "${DOTFILES_DIR}/.git" ]]; then
                git clone "https://gitlab.com/dotfiles30/comma_files.git" "${DOTFILES_DIR}"
        else
		git -C "${DOTFILES_DIR}" pull
	fi
fi

echo "${PASSWORD}" > "${PASSWORD_FILE_PATH}"

cd "${DOTFILES_DIR}"

# Determine distro
if [[ -f /etc/os-release ]]; then
        # Modern distributions use os-release file
        . /etc/os-release
        distro=${ID}
        version=${VERSION_ID}
elif [[ -f /etc/lsb-release ]]; then
        # Older Ubuntu/Debian systems
        . /etc/lsb-release
        distro=${DISTRIB_ID}
        version=${DISTRIB_RELEASE}
elif [[ -f /etc/redhat-release ]]; then
        # Older Red Hat based systems
        distro=$(cat /etc/redhat-release)
else
        # Fallback
        distro=$(uname -s)
        version=$(uname -r)
fi

echo "==== Configuring system ===="
echo "Distribution: ${distro}"
echo "Version: ${version}"
echo "==== ------------------ ===="

# Install Ansible
if ! [[ -x "$(command -v ansible || true)" ]]; then
        if [[ ${distro,,} == "arch" ]]; then
                sudo pacman -S ansible --noconfirm
        else
		# Update the system initially
                sudo apt-get update
                sudo apt-get upgrade

		# pipx is the best method to install ansible imo
		sudo apt install pipx -y

		# Add pipx to PATH
		sudo pipx ensurepath
		source ~/.bashrc

		# Ansible installation itself
		pipx install --include-deps ansible
        fi
fi

# Update Galaxy
ansible-galaxy install -r requirements.yml

# Setup password if not exists
if ! [[ -f "${DOTFILES_DIR}/vault-password.txt" ]]; then
        read -pr "Please enter your Ansible Vault password: " ANSIBLE_PASSWORD
        echo "${ANSIBLE_PASSWORD}" >>"${PASSWORD_FILE_PATH}"
fi

# Run playbook
ansible-playbook --diff --vault-password-file "${PASSWORD_FILE_PATH}" "${DOTFILES_DIR}/main.yml" "$@"

# vi:ft=sh:

