#!/usr/bin/env bats

@test "no arguments prints message and usage instructions" {
    run longestCommon
    [ $status -eq 2 ]
    [ "${lines[0]%% *}" = 'Usage:' ]
}

@test "invalid option prints message and usage instructions" {
    run longestCommon --invalid-option
    [ $status -eq 2 ]
    [ "${lines[0]}" = 'ERROR: Unknown option "--invalid-option"!' ]
    [ "${lines[2]%% *}" = 'Usage:' ]
}

@test "-h prints long usage help" {
  run longestCommon -h
    [ $status -eq 0 ]
    [ "${lines[0]%% *}" != 'Usage:' ]
}
