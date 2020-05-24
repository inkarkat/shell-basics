#!/usr/bin/env bats

@test "unknown option prints an error message" {
    run field --input "${BATS_TEST_DIRNAME}/tabbed.txt" --does-not-exist 2
    [ $status -eq 2 ]
    [ "${lines[0]}" = "ERROR: Unknown option \"--does-not-exist\"!" ]
    [ "${lines[3]%% *}" = "Usage:" ]
}

@test "a non-number argument at the end when removing prints an error message" {
    run field --input "${BATS_TEST_DIRNAME}/tabbed.txt" --remove 2 x 3 y
    [ $status -eq 2 ]
    [ "$output" = "ERROR: Not a number: x" ]
}
