#!/usr/bin/env bats

load fixture

@test "suffix removal of empty input is empty and returns 99" {
    runWithInput '' longestCommon --remove-suffix
    [ $status -eq 99 ]
    [ "$output" = "" ]
}

@test "suffix removal of single input line is empty" {
    runWithInput 'foo bar' longestCommon --remove-suffix
    [ $status -eq 0 ]
    [ "$output" = "" ]
}

@test "suffix removal of two identical input lines is empty" {
    runWithInput $'foo bar\nfoo bar' longestCommon --remove-suffix
    [ $status -eq 0 ]
    [ "$output" = "" ]
}

@test "suffix removal of two input lines" {
    runWithInput $'new signin\nold pin' longestCommon --remove-suffix
    [ $status -eq 0 ]
    [ "$output" = "new sign
old p" ]
}

@test "suffix removal of three input lines" {
    runWithInput $'pin\nin\nsignin' longestCommon --remove-suffix
    [ $status -eq 0 ]
    [ "$output" = "p

sign" ]
}

@test "suffix removal of three completely different input lines is identical to inpu and returns 99" {
    runWithInput $'loo\nfox\nfoony' longestCommon --remove-suffix
    [ $status -eq 99 ]
    [ "$output" = $'loo\nfox\nfoony' ]
}
