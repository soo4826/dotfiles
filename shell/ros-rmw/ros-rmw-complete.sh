#!/bin/bash

# Function for tab completion setup
_complete_rmw() {
    local cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $(compgen -W "fast cyclone connext opensplice goorm" -- $cur) )
}
complete -F _complete_rmw switch_rmw