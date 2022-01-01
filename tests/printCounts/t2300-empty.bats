#!/usr/bin/env bats

@test "custom empty output for a single count of 0" {
    run printCounts --empty 'no felines' 0 cat
    [ $status -eq 0 ]
    [ "$output" = "no felines" ]
}

@test "custom empty output for two counts of 0 and 0" {
    run printCounts --empty 'no animals were seen' 0 cat 0 dog
    [ $status -eq 0 ]
    [ "$output" = "no animals were seen" ]
}

@test "two counts of 0 and 1 ignore the custom empty output" {
    run printCounts --empty 'no animals were seen' 0 cat 1 dog
    [ $status -eq 0 ]
    [ "$output" = "1 dog" ]
}
