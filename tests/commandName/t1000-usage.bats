#!/usr/bin/env bats

load fixture

@test "no arguments prints undefined" {
    run -0 commandName
    assert_output 'undefined'
}

@test "invalid option prints message and usage instructions" {
    run -2 commandName --invalid-option
    assert_line -n 0 'ERROR: Unknown option "--invalid-option"!'
    assert_line -n 1 -e '^Usage:'
}

@test "-h prints long usage help" {
    run -0 commandName -h
    refute_line -n 0 -e '^Usage:'
}
