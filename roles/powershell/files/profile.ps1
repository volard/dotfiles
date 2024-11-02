# $env:userprofile/.config/powershell
Import-Module Terminal-Icons;


# PSReadLine
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows
# Override default tab completion
Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }
#Set-PSReadLineKeyHandler -Key Tab -Function Complete


#Fzf (Import the fuzzy finder and set a shortcut key to begin searching)
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

# configure FZF
$env:FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
$env:FZF_DEFAULT_OPTS="--border=rounded  --height=80%  --layout=reverse --inline-info --bind ctrl-a:select-all,ctrl-d:deselect-all,ctrl-t:toggle"

$env:FZF_CTRL_T_COMMAND=$env:FZF_DEFAULT_COMMAND
$env:FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :50 {}'"

# $env:FZF_ALT_C_COMMAND='fd --type d . --color=always --hidden'
$env:FZF_ALT_C_OPTS="--walker-skip .git,node_modules --preview 'eza -T --color=always --all --icons=always --git-ignore --level=2 --group-directories-first {}'"

# $env:FZF_ALT_C_OPTS="--walker-skip .git,node_modules --preview 'tree -C {}'"



# Utility Command that tells you where the absolute path of commandlets are 
function which ($command) { 
 Get-Command -Name $command -ErrorAction SilentlyContinue | 
 Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue 
}


# ---------------------------
# Vars
# ---------------------------
# $pwsh_config = "$([Environment]::getfolderpath("MyDocuments"))\PowerShell";
$pwsh_config      = "$($env:userprofile)\.config\powershell";
$nvim_config      = "$($env:localappdata)\nvim";
$alacritty_config = "$($env:appdata)\alacritty";


# ---------------------------
# Aliases
# ---------------------------
function parent {set-location ..};
set-alias .. parent;
# ------

function show_in_explorer {explorer.exe .};
set-alias show show_in_explorer;

function open_nvim_sudo_folder {sudo nvim .}
set-alias svv open_nvim_sudo_folder;

function open_nvim_folder {nvim .}
set-alias vv open_nvim_folder;


function list_files {exa -laF --icons --color --group-directories-first};
set-alias l list_files;
# ------

set-alias v nvim;
set-alias vf vifm;
set-alias lg lazygit;
set-alias touch ni;
set-alias trash remove-itemsafely;


function yy {
    $tmp = [System.IO.Path]::GetTempFileName()
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -LiteralPath $cwd
    }
    Remove-Item -Path $tmp
}

# enable fancy oh-my-posh
oh-my-posh init pwsh --config ~/.config/oh-my-posh/amro.omp.json | Invoke-Expression;

# use z instead of cd - zoxide
Invoke-Expression (& { (zoxide init powershell | Out-String) }); 

clear; # clear welcoming pwsh message

