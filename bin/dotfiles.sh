#!/bin/bash

# color codes
RESTORE='\033[0m'
NC='\033[0m'
BLACK='\033[00;30m'
RED='\033[00;31m'
GREEN='\033[00;32m'
YELLOW='\033[00;33m'
BLUE='\033[00;34m'
PURPLE='\033[00;35m'
CYAN='\033[00;36m'
SEA='\033[38;5;49m'
LIGHTGRAY='\033[00;37m'
LBLACK='\033[01;30m'
LRED='\033[01;31m'
LGREEN='\033[01;32m'
LYELLOW='\033[01;33m'
LBLUE='\033[01;34m'
LPURPLE='\033[01;35m'
LCYAN='\033[01;36m'
WHITE='\033[01;37m'
OVERWRITE='\e[1A\e[K'

#emoji codes
CHECK_MARK="${GREEN}\xE2\x9C\x94${NC}"
X_MARK="${RED}\xE2\x9C\x96${NC}"
PIN="${RED}\xF0\x9F\x93\x8C${NC}"
CLOCK="${GREEN}\xE2\x8C\x9B${NC}"
ARROW="${SEA}\xE2\x96\xB6${NC}"
BOOK="${RED}\xF0\x9F\x93\x8B${NC}"
HOT="${ORANGE}\xF0\x9F\x94\xA5${NC}"
WARNING="${RED}\xF0\x9F\x9A\xA8${NC}"
RIGHT_ANGLE="${GREEN}\xE2\x88\x9F${NC}"

set -e

# paths
DOTFILES_DIR="${HOME}/dotfiles"
PASSWORD_FILE_PATH="${DOTFILES_DIR}/vault-password.txt"

mkdir -p ${CONFIG_DIR}
rm -r $CONFIG_DIR

# Clone repository or pull
if ! [[ -d $DOTFILES_DIR ]]; then
	git clone "https://github.com/ALT-F4-LLC/dotfiles.git" "$DOTFILES_DIR"
else
	git -C "$DOTFILES_DIR" pull
fi

cd "$DOTFILES_DIR"

# Determine distro
if [ -f /etc/os-release ]; then
	# Modern distributions use os-release file
	. /etc/os-release
	distro=$ID
	version=$VERSION_ID
elif [ -f /etc/lsb-release ]; then
	# Older Ubuntu/Debian systems
	. /etc/lsb-release
	distro=$DISTRIB_ID
	version=${DISTRIB_RELEASE}
elif [ -f /etc/redhat-release ]; then
	# Older Red Hat based systems
	distro=$(cat /etc/redhat-release)
else
	# Fallback
	distro=$(uname -s)
	version=$(uname -r)
fi

echo "==== Configuring system ===="
echo "Distribution: $distro"
echo "Version: $version"

# Install Ansible
if ! [ -x "$(command -v ansible)" ]; then
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

		pip3 install molecule molecule-docker
	fi
fi

# Update Galaxy
ansible-galaxy install -r requirements.yml

# Setup password if not exists
if ! [[ -f "$DOTFILES_DIR/vault-password.txt" ]]; then
	read -p "Please enter your Ansible Vault password: " ANSIBLE_PASSWORD
	echo $ANSIBLE_PASSWORD >>$PASSWORD_FILE_PATH
fi

# Run playbook
ansible-playbook --diff --vault-password-file $PASSWORD_FILE_PATH "$DOTFILES_DIR/main.yaml" "$@"

# vi:ft=sh:
