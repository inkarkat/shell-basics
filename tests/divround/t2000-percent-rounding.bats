#!/usr/bin/env bats

@test "percent rounding" {
    run divround 50
    [ $status -eq 0 ]
    [ "$output" = "0.5" ]
}
