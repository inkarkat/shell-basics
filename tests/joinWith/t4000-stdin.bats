#!/usr/bin/env bats

inputWrapper()
{
    local input="$1"; shift
    printf "%s${input:+\n}" "$input" | "$@"
}
runWithInput()
{
    run inputWrapper "$@"
}

@test "joining lines from stdin" {
    runWithInput $'foo\n\nbar\nbaz' joinWith --default-separator ', '
    [ $status -eq 0 ]
    [ "$output" = "foo, , bar, baz" ]
}

@test "joining lines from stdin omitting empty lines" {
    runWithInput $'\nfoo\n\n\nbar\n\nbaz' joinWith --default-separator ', ' --omit-empty
    [ $status -eq 0 ]
    [ "$output" = "foo, bar, baz" ]
}
