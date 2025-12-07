#!/usr/bin/env bats

load fixture

@test "custom empty output for a single count of 0" {
    run -0 printCounts --empty 'no felines' 0 cat
    assert_output 'no felines'
}

@test "custom empty output for two counts of 0 and 0" {
    run -0 printCounts --empty 'no animals were seen' 0 cat 0 dog
    assert_output 'no animals were seen'
}

@test "two counts of 0 and 1 ignore the custom empty output" {
    run -0 printCounts --empty 'no animals were seen' 0 cat 1 dog
    assert_output '1 dog'
}
