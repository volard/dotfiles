FROM ubuntu:22.04

HEALTHCHECK NONE

RUN useradd -d /home/username -m -s /bin/bash username
USER username

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get update && apt-get install -y \
    ansible=2.17.5 \
    python3-pip=22.0.2 \
    git=2.34.1 --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /home/dotfiles

# Copy the dotfiles and the playbook into the container
COPY . .

# Set the entrypoint to run Ansible
ENTRYPOINT ["ansible-playbook", "playbook.yml", "-i", "localhost,"]