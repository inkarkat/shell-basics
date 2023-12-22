#!/usr/bin/env bats

@test "join omitting empty arguments" {
    run joinWith --omit-empty foo '' bar '' '' '' baz ''
    [ $status -eq 0 ]
    [ "$output" = "foo bar baz" ]
}
