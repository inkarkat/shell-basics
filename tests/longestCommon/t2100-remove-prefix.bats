#!/usr/bin/env bats

load fixture

@test "prefix removal of empty input is empty and returns 99" {
    runWithInput '' longestCommon --remove-prefix
    [ $status -eq 99 ]
    [ "$output" = "" ]
}

@test "prefix removal of single input line is empty" {
    runWithInput 'foo bar' longestCommon --remove-prefix
    [ $status -eq 0 ]
    [ "$output" = "" ]
}

@test "prefix removal of two identical input lines is empty" {
    runWithInput $'foo bar\nfoo bar' longestCommon --remove-prefix
    [ $status -eq 0 ]
    [ "$output" = "" ]
}

@test "prefix removal of two input lines" {
    runWithInput $'foo bar\nfoxy lady' longestCommon --remove-prefix
    [ $status -eq 0 ]
    [ "$output" = "o bar
xy lady" ]
}

@test "prefix removal of three input lines" {
    runWithInput $'fox\nfo\nfoony' longestCommon --remove-prefix
    [ $status -eq 0 ]
    [ "$output" = "x

ony" ]
}

@test "prefix removal of three completely different input lines is identical to inpu and returns 99" {
    runWithInput $'loo\nfox\nfoony' longestCommon --remove-prefix
    [ $status -eq 99 ]
    [ "$output" = $'loo\nfox\nfoony' ]
}
