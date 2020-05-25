#!/usr/bin/env bats

@test "no passed field prints an error message" {
    run fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --regexp .
    [ $status -eq 2 ]
    [ "${lines[0]}" = "ERROR: No field number N passed." ]
    [ "${lines[3]%% *}" = "Usage:" ]
}

@test "no inverted passed field prints an error message" {
    run fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' --invert-fields --regexp .
    [ $status -eq 2 ]
    [ "${lines[0]}" = "ERROR: No field number N passed." ]
    [ "${lines[3]%% *}" = "Usage:" ]
}
