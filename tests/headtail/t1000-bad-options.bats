#!/usr/bin/env bats

@test "unknown option prints an error message" {
    run headtail --does-not-exist
    [ $status -eq 2 ]
    [ "${lines[0]}" = "ERROR: Unknown option \"--does-not-exist\"!" ]
    [ "${lines[-2]%% *}" = "Usage:" ]
}
