#!/usr/bin/env bats

@test "-h prints long usage help" {
    run printCounts -h
    [ $status -eq 0 ]
    [ "${lines[0]%% *}" != 'Usage:' ]
    [ "${lines[1]%% *}" = 'Usage:' ]
}
