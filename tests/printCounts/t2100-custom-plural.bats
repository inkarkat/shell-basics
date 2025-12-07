#!/usr/bin/env bats

load fixture

@test "print two counts of mice" {
    run -0 printCounts 1 mouse,mice 2 mouse,mice
    assert_output '1 mouse and 2 mice'
}
