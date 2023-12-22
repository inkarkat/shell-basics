#!/usr/bin/env bats

@test "join with prefix" {
    run joinWith --prefix 'Here:' foo bar baz
    [ "$status" -eq 0 ]
    [ "$output" = "Here:foo bar baz" ]
}

@test "join with suffix" {
    run joinWith --suffix ';duh' foo bar baz
    [ "$status" -eq 0 ]
    [ "$output" = "foo bar baz;duh" ]
}

@test "join with prefix and suffix" {
    run joinWith --prefix '[' --suffix ']' foo bar baz
    [ "$status" -eq 0 ]
    [ "$output" = "[foo bar baz]" ]
}
