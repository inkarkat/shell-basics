#!/usr/bin/env bats

@test "no numerical NUM prints an error message" {
    run headtail --lines 123abc
    [ $status -eq 2 ]
    [ "$output" = "headtail: invalid number of lines: 123abc" ]
}

@test "negative NUM prints an error message" {
    run headtail --lines -10
    [ $status -eq 2 ]
    [ "$output" = "headtail: invalid number of lines: -10" ]
}
