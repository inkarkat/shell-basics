#!/usr/bin/env bats

load fixture

@test "no arguments prints usage" {
    run -2 divround
    assert_line -n -1 -e '^Usage:'
}

@test "-h prints long usage help" {
    run -0 divround -h
    refute_line -n 0 -e '^Usage:'
}
