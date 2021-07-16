# no greeting
function fish_greeting
end

# prompt
starship init fish | source

# virtual per-project environment
direnv hook fish | source

# local vars
set EDITOR "emacsclient -t"
set ALTERNATE_EDITOR ""
set EDITOR "emacsclient -c"
set GOSUMDB off
set GOPATH $HOME/go
# set -gx DISPLAY (cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0

# global
set -gx FABPATH $HOME/repos/github.com/zencoder

# path
set -gx PATH $HOME/dotfiles/scripts $PATH
set -gx PATH $HOME/repos/github.com/zencoder/bolt-utils/bin $PATH
set -gx PATH $GOPATH/bin $PATH

# aliases

alias ll="exa -la"

# abbr

abbr tree exa -la -T
abbr rel 'exec $SHELL -l'
abbr vim nvim
