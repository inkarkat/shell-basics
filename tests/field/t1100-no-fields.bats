#!/usr/bin/env bats

@test "no passed field prints an error message" {
    run field --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t'
    [ $status -eq 2 ]
    [ "${lines[0]}" = "ERROR: No field number N passed." ]
    [ "${lines[3]%% *}" = "Usage:" ]
}

@test "no passed field only separators prints an error message" {
    run field --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' ' ' ' '
    [ $status -eq 2 ]
    [ "${lines[0]}" = "ERROR: No field number N passed." ]
    [ "${lines[3]%% *}" = "Usage:" ]
}

@test "no passed field to remove prints an error message" {
    run field --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --remove
    [ $status -eq 2 ]
    [ "${lines[0]}" = "ERROR: No field number N passed." ]
    [ "${lines[3]%% *}" = "Usage:" ]
}

