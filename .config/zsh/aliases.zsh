# aliases for zsh and bash
# this file in sourced in .zshrc and .bashrc

# lf stuff
lfcd() {
    dir="$(lf -print-last-dir "$@")"
    while ! cd "$dir" 2>/dev/null; do
        dir="$(dirname -- "$dir")"
    done
}

alias t='tmux a || tmux'

# misc
alias v='nvim'
alias sv='sudoedit'
alias s='sudo'
alias rg='rg -p' 
alias cls='clear'
alias cp='cp -v'
alias mv='mv -v'
alias rm='trash-put'

# adding some colors :3
alias ls='ls --color=always'
alias grep='grep --color=always'
alias ip='ip --color=always'
alias diff='diff --color=always'

# Faster movement
alias ..='cd ..'
alias .2='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

alias .a='cd ~/.cache'
alias .c='cd ~/.config'
alias .d='cd ~/Documents'
alias .D='cd ~/Downloads'
alias .h='cd ~'
alias .l='cd ~/.local/share'
alias .m='cd ~/Music'
alias .M='cd /run/media/$USER'
alias .p='cd ~/Pictures'
alias .r='cd ~/Repos'
alias .t='cd ~/.local/share/Trash/files'
alias .v='cd ~/Videos'

alias f='cd "$(find . -maxdepth 5 -type d -print | fzf --preview "eza --icons=always --color=always --group-directories-first -1 {}")"' 
alias gf='cd "$(find ~ -maxdepth 5 -type d -print | fzf --preview "eza --icons=always --color=always --group-directories-first -1 {}")"'

# Replacing ls with eza
alias l='eza --icons=always --color=always --group-directories-first'
alias la='eza --icons=always --color=always --group-directories-first -a'
alias ll='eza --icons=always --color=always --group-directories-first -la --no-time'
alias lt='eza --icons=always --color=always --group-directories-first -T'

# Replacing cat with bat
alias c='bat -P --color=always --style=plain --theme=base16 --wrap=auto'

alias cal='cal -m'

# Package Managment
alias ySyu='yay -Syu --noconfirm --quiet --color=always && flatpak update -y'
alias yS='yay -S --noconfirm --color=always'
alias yRns='yay -Rns --noconfirm --color=always'

alias pSyu='sudo pacman -Syu'
alias pS='sudo pacman -S'
alias pRns='sudo pacman -Rns'

alias rem='sudo pacman -Rns $(pacman -Qq | fzf -m) --color=always'
alias cleanup='sudo pacman -Rns $(pacman -Qtdq) --color=always'

# Change Shells
alias tobash="sudo chsh $USER -s /bin/bash && bash"
alias tozsh="sudo chsh $USER -s /bin/zsh && zsh"
alias tofish="sudo chsh $USER -s /bin/fish && fish"

# Toggle Starship Modules
alias toggle-user='starship toggle username'
alias toggle-host='starship toggle hostname'
alias toggle-dir='starship toggle directory'
alias toggle-git='starship toggle git_branch'
alias toggle-duration='starship toggle cmd_duration'

alias ga="git add . && git status"
alias gc="git commit -m"
alias gp="git push"
alias gco="git checkout"
alias gpu="git pull"
alias gs="git status"

# Silly
alias fucking='sudo'
alias okpa='systemctl poweroff'
