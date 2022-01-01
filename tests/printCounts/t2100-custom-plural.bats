#!/usr/bin/env bats

@test "print two counts of mice" {
    run printCounts 1 mouse,mice 2 mouse,mice
    [ $status -eq 0 ]
    [ "$output" = "1 mouse and 2 mice" ]
}
