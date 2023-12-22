#!/usr/bin/env bats

@test "join all arguments with spaces by default" {
    run joinWith foo bar baz
    [ "$status" -eq 0 ]
    [ "$output" = "foo bar baz" ]
}

@test "join all arguments with -" {
    run joinWith --default-separator - foo bar baz
    [ "$status" -eq 0 ]
    [ "$output" = "foo-bar-baz" ]
}

@test "join all arguments with commas" {
    run joinWith --default-separator ', ' foo bar baz
    [ "$status" -eq 0 ]
    [ "$output" = "foo, bar, baz" ]
}
