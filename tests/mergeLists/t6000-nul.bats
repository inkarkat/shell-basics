#!/usr/bin/env bats

wrapper()
{
    local replacement="${1:?}"; shift
    local status
    "$@" | tr '\0' "$replacement"
    return ${PIPESTATUS[0]}
}
runWithNulAs()
{
    run wrapper "$@"
}

@test "merge args and output with NUL separator also ends the output with NUL" {
    runWithNulAs X mergeLists --output-separator '\0' foo bar baz baz foo quux foo
    [ $status -eq 0 ]
    [ "$output" = 'fooXbarXbazXquuxX' ]
}
