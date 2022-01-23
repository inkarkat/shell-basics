#!/usr/bin/env bats

@test "no arguments prints usage" {
    run divround
    [ $status -eq 2 ]
    [ "${lines[-1]%% *}" = 'Usage:' ]
}

@test "-h prints long usage help" {
    run divround -h
    [ $status -eq 0 ]
    [ "${lines[0]%% *}" != 'Usage:' ]
}
