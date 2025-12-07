#!/usr/bin/env bats

load fixture

@test "no numerical NUM prints an error message" {
    run -2 headtail --lines 123abc
    assert_output 'headtail: invalid number of lines: 123abc'
}
