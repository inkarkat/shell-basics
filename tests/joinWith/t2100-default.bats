#!/usr/bin/env bats

load fixture

@test "join all arguments with spaces by default" {
    run -0 joinWith foo bar baz
    assert_output 'foo bar baz'
}

@test "join all arguments with -" {
    run -0 joinWith --default-separator - foo bar baz
    assert_output 'foo-bar-baz'
}

@test "join all arguments with commas" {
    run -0 joinWith --default-separator ', ' foo bar baz
    assert_output 'foo, bar, baz'
}
