#!/usr/bin/env bats

@test "unknown option prints an error message" {
    run fieldDefault --input "${BATS_TEST_DIRNAME}/tabbed.txt" --value DEFAULT --does-not-exist 2
    [ $status -eq 2 ]
    [ "$output" = "ERROR: Unknown option \"--does-not-exist\"!" ]
}

@test "invalid LIST prints an error message" {
    run fieldDefault --input "${BATS_TEST_DIRNAME}/tabbed.txt" --value DEFAULT 1-2-3
    [ $status -eq 2 ]
    [ "$output" = "ERROR: Invalid LIST: 1-2-3" ]
}

@test "missing value prints an error message" {
    run fieldDefault --input "${BATS_TEST_DIRNAME}/tabbed.txt" 2
    [ $status -eq 2 ]
    [ "${lines[0]}" = "ERROR: No -v|--value VAL passed." ]
    [ "${lines[2]%% *}" = "Usage:" ]
}

@test "missing LIST prints an error message" {
    run fieldDefault --input "${BATS_TEST_DIRNAME}/tabbed.txt" --value DEFAULT
    [ $status -eq 2 ]
    [ "${lines[0]}" = "ERROR: No LIST passed." ]
    [ "${lines[2]%% *}" = "Usage:" ]
}
