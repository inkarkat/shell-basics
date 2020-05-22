#!/usr/bin/env bats

@test "unknown option prints an error message" {
    run fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" --does-not-exist 2
    [ $status -eq 2 ]
    [ "${lines[0]}" = "ERROR: Unknown option \"--does-not-exist\"!" ]
    [ "${lines[3]%% *}" = "Usage:" ]
}

@test "missing regexp prints an error message" {
    run fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" 2
    [ $status -eq 2 ]
    [ "${lines[0]}" = "ERROR: No GREP-OPTIONS passed." ]
    [ "${lines[3]%% *}" = "Usage:" ]
}

@test "regular expression field separator prints an error message" {
    run fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F ' +' --regexp . 2
    [ $status -eq 2 ]
    [ "$output" = "ERROR: The field separator has to be a literal string; it cannot be a regular expression." ]
}

@test "a non-number argument at the end prints an error message" {
    run fieldGrep --input "${BATS_TEST_DIRNAME}/tabbed.txt" --regexp . 2 x 3 y
    [ $status -eq 2 ]
    [ "$output" = "ERROR: Not a number: x" ]
}
