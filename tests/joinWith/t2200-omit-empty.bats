#!/usr/bin/env bats

load fixture

@test "join omitting empty arguments" {
    run -0 joinWith --omit-empty foo '' bar '' '' '' baz ''
    assert_output 'foo bar baz'
}
