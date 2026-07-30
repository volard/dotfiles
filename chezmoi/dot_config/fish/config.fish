set -g fish_greeting

if status is-interactive
    if command -q starship
        starship init fish | source
    end

    if command -q zoxide
        zoxide init fish | source
    end

    if command -q atuin
        atuin init fish | source
    end

    if test -f /usr/share/fzf/key-bindings.fish
        source /usr/share/fzf/key-bindings.fish
    end

    if test -f /usr/share/fzf/completion.fish
        source /usr/share/fzf/completion.fish
    end
end

function dnp
    docker container ls --format 'table {{.ID}}\t{{.Names}}\t{{.Ports}}' -a $argv
end

alias dip="docker image prune -fa"
alias dil="docker images"
alias dcu="docker-compose up -d"
alias dcub="docker-compose up -d --build"
alias dcs="docker-compose stop"
alias dcd="docker-compose down"
alias dcr="docker-compose restart"
alias dcl="docker-compose logs"
alias dclf="docker-compose logs -f"
alias dex="docker exec -it"
alias dps="docker ps"
alias grep="rg"
alias ll="eza -lh --git --icons --color=always -a --group-directories-first --sort=modified"
alias ls="eza --icons --all --long --group-directories-first --sort=modified"
alias lg="lazygit"
alias lint-ais="precommit"
alias lzd="lazydocker"
alias vv="nvim ."
alias v="nvim"

function dsa
    docker ps -q | awk '{print $1}' | xargs -o docker stop
end

function precommit
    set -l url 'https://git.roadcons.ru/volard/ais2-editor-configs/-/raw/main/pre-commit.sh'
    set -l file './pre-commit.sh'

    if not test -f "$file"
        curl -fsSL -o "$file" "$url"; or return $status
        chmod +x "$file"; or return $status

        if test -d .git
            set -l name (basename "$file")
            grep -qxF "$name" .gitignore 2>/dev/null; or printf '%s\n' "$name" >> .gitignore
        end
    end

    "$file" $argv
end
