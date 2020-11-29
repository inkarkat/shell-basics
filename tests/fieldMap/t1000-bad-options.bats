#!/usr/bin/env bats

@test "unknown option prints an error message" {
    run fieldMap --does-not-exist -- "${BATS_TEST_DIRNAME}/tabbed.txt"
    [ $status -eq 2 ]
    [ "${lines[0]}" = "ERROR: Unknown option \"--does-not-exist\"!" ]
    [ "${lines[2]%% *}" = "Usage:" ]
}

@test "no N prints an error message" {
    run fieldMap "${BATS_TEST_DIRNAME}/tabbed.txt"
    [ $status -eq 2 ]
    [ "${lines[0]}" = "ERROR: No [-]N AWK-EXPR passed." ]
    [ "${lines[2]%% *}" = "Usage:" ]
}
