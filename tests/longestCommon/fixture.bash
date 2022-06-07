#!/bin/bash

inputWrapper()
{
    local input="$1"; shift
    printf "%s${input:+\\n}" "$input" | "$@"
}
runWithInput()
{
    run inputWrapper "$@"
}
