#!/usr/bin/env bats

load fixture

@test "no arguments no output" {
    run -99 joinWith --
    assert_output ''
}

@test "empty text" {
    run -0 joinWith --empty '(none)' --
    assert_output '(none)'
}

@test "omit empty" {
    run -0 joinWith --empty '(none)' --omit-empty -- '' ''
    assert_output '(none)'
}

@test "empty with prefix and suffix" {
    run -0 joinWith --empty '(none)' --prefix '[' --suffix ']' --
    assert_output '[(none)]'
}
