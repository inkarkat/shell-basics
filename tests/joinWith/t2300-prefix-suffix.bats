#!/usr/bin/env bats

load fixture

@test "join with prefix" {
    run -0 joinWith --prefix 'Here:' foo bar baz
    assert_output 'Here:foo bar baz'
}

@test "join with suffix" {
    run -0 joinWith --suffix ';duh' foo bar baz
    assert_output 'foo bar baz;duh'
}

@test "join with prefix and suffix" {
    run -0 joinWith --prefix '[' --suffix ']' foo bar baz
    assert_output '[foo bar baz]'
}
