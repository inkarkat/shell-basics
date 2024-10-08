#!/bin/bash source-this-script

_trace_complete()
{
    local IFS=$'\n'
    local cur args opts

    opts='-f --for -F --only-for -p --paginate --inbox'
    opts="${opts// /$'\n'}"
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"

    args="$(MANN_BLACKLIST_FILESPEC=/dev/null mann --commands "$cur")"

    readarray -t COMPREPLY < <(compgen -W "${opts}${args:+${opts:+$'\n'}}$args" -- "$cur")
    [ ${#COMPREPLY[@]} -gt 0 ] && readarray -t COMPREPLY < <(printf "%q\n" "${COMPREPLY[@]}")
    return 0
}
complete -F _trace_complete trace
