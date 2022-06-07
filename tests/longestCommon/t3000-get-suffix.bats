#!/usr/bin/env bats

load fixture

@test "suffix of empty input is empty" {
    runWithInput '' longestCommon --get-suffix
    [ $status -eq 0 ]
    [ "$output" = "" ]
}

@test "suffix of single input line is that input line" {
    runWithInput 'foo bar' longestCommon --get-suffix
    [ $status -eq 0 ]
    [ "$output" = "foo bar" ]
}

@test "suffix of two identical input lines is the entire input line" {
    runWithInput $'foo bar\nfoo bar' longestCommon --get-suffix
    [ $status -eq 0 ]
    [ "$output" = "foo bar" ]
}

@test "suffix of two input lines" {
    runWithInput $'new signin\nold pin' longestCommon --get-suffix
    [ $status -eq 0 ]
    [ "$output" = "in" ]
}

@test "suffix of three input lines" {
    runWithInput $'pin\nin\nsignin' longestCommon --get-suffix
    [ $status -eq 0 ]
    [ "$output" = "in" ]
}

@test "suffix of three completely different input lines is empty and returns 99" {
    runWithInput $'loo\nfox\nfoony' longestCommon --get-suffix
    [ $status -eq 99 ]
    [ "$output" = "" ]
}
