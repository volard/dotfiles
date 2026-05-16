set shell := ["bash", "-euo", "pipefail", "-c"]

# Refresh vaulted SSH files from ~/.ssh
refresh-ssh-files:
    mkdir -p roles/ssh/files
    find roles/ssh/files -mindepth 1 -maxdepth 1 -type f -delete
    while IFS= read -r -d '' file; do \
      cp "$file" "roles/ssh/files/$(basename "$file")"; \
    done < <(find "${HOME}/.ssh" -mindepth 1 -maxdepth 1 -type f -print0)
    while IFS= read -r -d '' file; do \
      ansible-vault encrypt --encrypt-vault-id default "$file"; \
    done < <(find roles/ssh/files -mindepth 1 -maxdepth 1 -type f -print0)

refresh-waybinder-files:
    mkdir -p roles/waybinder/files/snippets
    find roles/waybinder/files/snippets -mindepth 1 -maxdepth 1 -type f -delete
    while IFS= read -r -d '' file; do \
      cp "$file" "roles/waybinder/files/snippets/$(basename "$file")"; \
    done < <(find "${HOME}/.config/waybinder" -mindepth 1 -maxdepth 1 -type f -print0)
    while IFS= read -r -d '' file; do \
      ansible-vault encrypt --encrypt-vault-id default "$file"; \
    done < <(find roles/waybinder/files/snippets -mindepth 1 -maxdepth 1 -type f -print0)

decrypt-waybinder-files:
    while IFS= read -r -d '' file; do \
      ansible-vault decrypt --vault-id default "$file"; \
    done < <(find roles/waybinder/files/snippets -mindepth 1 -maxdepth 1 -type f -print0)

encrypt-waybinder-files:
    while IFS= read -r -d '' file; do \
      ansible-vault encrypt --encrypt-vault-id default "$file"; \
    done < <(find roles/waybinder/files/snippets -mindepth 1 -maxdepth 1 -type f -print0)
