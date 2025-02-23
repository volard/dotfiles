#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[ -f /home/volard/.dart-cli-completion/bash-config.bash ] && . /home/volard/.dart-cli-completion/bash-config.bash || true
## [/Completion]


if command -v mise &> /dev/null; then
  eval "$(mise activate bash --shims)"
fi

