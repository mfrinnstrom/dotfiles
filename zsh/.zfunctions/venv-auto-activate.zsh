#!/bin/zsh
#
# Auto activate a python virtualenv when entering the project directory.
# Installation:
#   source virtualenv-auto-activate.sh
#
# Usage:
#   Function `venvconnect`:
#       Connect the currently activated virtualenv to the current directory.
#
VENV_HOME=$HOME/.virtualenvs

function _virtualenv_auto_activate() {
    if [[ -f ".venv" ]]; then
        _VENV_PATH=$VENV_HOME/$(cat .venv)

        # Check to see if already activated to avoid redundant activating
        if [[ "$VIRTUAL_ENV" != $_VENV_PATH ]]; then
            source $_VENV_PATH/bin/activate
        fi
    fi
}

function venvconnect (){
    if [[ -n $VIRTUAL_ENV ]]; then
        echo $(basename $VIRTUAL_ENV) > .venv
    else
        echo "Activate a virtualenv first"
    fi
}

function venvcreate (){
    if [[ -z $VIRTUAL_ENV ]]; then
        VENV_NAME=$(basename $PWD)
        echo "Creating new virtual environment: $VENV_NAME"
        python -m venv $VENV_HOME/$VENV_NAME
        source $VENV_HOME/$VENV_NAME/bin/activate
        venvconnect
    else
        echo "Virtual environment already exists."
    fi
}

chpwd_functions+=(_virtualenv_auto_activate)
precmd_functions=(_virtualenv_auto_activate $precmd_functions)

