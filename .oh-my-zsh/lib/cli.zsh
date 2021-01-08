#!/usr/bin/env zsh

function omz {
    [[ $# -gt 0 ]] || {
        _omz::menu
        return 1
    }

    local command="$1"
    shift

    # Subcommand functions start with _ so that they don't
    # appear as completion entries when looking for `omz`
    (( $+functions[_omz::$command] )) || {
        _omz::menu
        return 1
    }

    _omz::$command "$@"
}

function _omz {
    local -a cmds subcmds
    cmds=(
        'help:Usage information'
        'update:Update Oh My Zsh'
    )
}

compdef _omz omz

function _omz::menu {
    cat <<EOF
Usage: omz <command> [options]

Available commands:

    help                Print this help message
    update              Update Oh My Zsh

EOF
}


function _omz::help {
    # Get help
    theme-engine --help
}

function _omz::update {
    # Run update script
    env ZSH="$ZSH" bash "$ZSH/tools/upgrade.sh"
}


