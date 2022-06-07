#!/usr/bin/env bats

load fixture

@test "prefix of empty input is empty" {
    runWithInput '' longestCommon --get-prefix
    [ $status -eq 0 ]
    [ "$output" = "" ]
}

@test "prefix of single input line is that input line" {
    runWithInput 'foo bar' longestCommon --get-prefix
    [ $status -eq 0 ]
    [ "$output" = "foo bar" ]
}

@test "prefix of two identical input lines is the entire input line" {
    runWithInput $'foo bar\nfoo bar' longestCommon --get-prefix
    [ $status -eq 0 ]
    [ "$output" = "foo bar" ]
}

@test "prefix of two input lines" {
    runWithInput $'foo bar\nfoxy lady' longestCommon --get-prefix
    [ $status -eq 0 ]
    [ "$output" = "fo" ]
}

@test "prefix of three input lines" {
    runWithInput $'fox\nfo\nfoony' longestCommon --get-prefix
    [ $status -eq 0 ]
    [ "$output" = "fo" ]
}

@test "prefix of three completely different input lines is empty and returns 99" {
    runWithInput $'loo\nfox\nfoony' longestCommon --get-prefix
    [ $status -eq 99 ]
    [ "$output" = "" ]
}
