# Use an official Ubuntu as a parent image
FROM ubuntu:latest

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get update && apt-get install -y \
    ansible \
    python3-pip \
    git \
    && apt-get clean

# Set the working directory
WORKDIR /dotfiles

# Copy the dotfiles and the playbook into the container
COPY . .

# Set the entrypoint to run Ansible
ENTRYPOINT ["ansible-playbook", "playbook.yml", "-i", "localhost,"]