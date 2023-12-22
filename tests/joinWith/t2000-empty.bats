#!/usr/bin/env bats

@test "no arguments no output" {
    run joinWith --
    [ $status -eq 99 ]
    [ "$output" = "" ]
}

@test "empty text" {
    run joinWith --empty '(none)' --
    [ $status -eq 0 ]
    [ "$output" = "(none)" ]
}

@test "omit empty" {
    run joinWith --empty '(none)' --omit-empty -- '' ''
    [ $status -eq 0 ]
    [ "$output" = "(none)" ]
}

@test "empty with prefix and suffix" {
    run joinWith --empty '(none)' --prefix '[' --suffix ']' --
    [ $status -eq 0 ]
    [ "$output" = "[(none)]" ]
}
