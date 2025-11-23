[[ $- == *i* ]] && {
    set -o vi

    . -- /usr/share/blesh/ble.sh --attach=none

    [[ $PS1 && ! ${BASH_COMPLETION_VERSINFO:-} && -f /usr/share/bash-completion/bash_completion ]] && . /usr/share/bash-completion/bash_completion
    PS1='\[\e[35m\][\[\e[34m\]\u\[\e[0m\]@\[\e[34m\]\h\[\e[35m\]] [\[\e[34m\]\w\[\e[35m\]] \n> \[\e[0m\]'

    [[ -f ~/.config/shell/aliases.sh ]] && . ~/.config/shell/aliases.sh
    [[ -f ~/.config/shell/env.sh ]] && . ~/.config/shell/env.sh

    export HISTFILE="${XDG_STATE_HOME}"/bash/history

    eval "$(zoxide init bash --cmd cd)"


}

[[ ! ${BLE_VERSION-} ]] || ble-attach
