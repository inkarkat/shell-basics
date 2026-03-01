#!/usr/bin/env bats

load fixture

@test "no arguments prints usage instructions" {
    run -2 combineNames
    assert_line -n 0 -e '^Usage:'
}

@test "no NAME(s) prints message and usage instructions" {
    run -2 combineNames --range
    assert_line -n 0 'ERROR: No NAME(s) passed.'
    assert_line -n 1 -e '^Usage:'
}

@test "invalid option prints message and usage instructions" {
    run -2 combineNames --invalid-option
    assert_line -n 0 'ERROR: Unknown option "--invalid-option"!'
    assert_line -n 1 -e '^Usage:'
}

@test "-h prints long usage help" {
    run -0 combineNames -h
    refute_line -n 0 -e '^Usage:'
}
