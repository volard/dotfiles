#!/bin/bash

set -e

# paths
DOTFILES_DIR="${HOME}/dotfiles"
PASSWORD_FILE_PATH="${DOTFILES_DIR}/vault-password.txt"

read -s -p "Enter vault password: " PASSWORD

# Clone repository or pull
if ! [[ -d ${DOTFILES_DIR} ]]; then
	git clone "https://gitlab.com/dotfiles30/comma_files.git" "${DOTFILES_DIR}"
else
	git -C "${DOTFILES_DIR}" pull
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

# Install Ansible
if ! [[ -x "$(command -v ansible || true)" ]]; then
	if [[ ${distro,,} == "arch" ]]; then
		sudo pacman -S ansible --noconfirm
	else
		sudo apt-get update
		sudo apt-add-repository ppa:ansible/ansible
		sudo apt-get update
		sudo apt-get upgrade
		sudo apt install python3-pip -y
		pip3 install pywinrm
		pip3 install pyvmomi
		pip3 install ansible
		pip3 install ansible-creator
		pip3 install ansible-dev-environment --user

		pip3 install molecule molecule-docker
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
ansible-playbook --diff --vault-password-file "${PASSWORD_FILE_PATH}" "${DOTFILES_DIR}/main.yaml" "$@"

# vi:ft=sh:
