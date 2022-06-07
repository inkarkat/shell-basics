#!/usr/bin/env bats

load fixture

@test "both removal of empty input is empty and returns 99" {
    runWithInput '' longestCommon --remove-both
    [ $status -eq 99 ]
    [ "$output" = "" ]
}

@test "both removal of single input line is empty" {
    runWithInput 'foo bar' longestCommon --remove-both
    [ $status -eq 0 ]
    [ "$output" = "" ]
}

@test "both removal of two identical input lines is empty" {
    runWithInput $'foo bar\nfoo bar' longestCommon --remove-both
    [ $status -eq 0 ]
    [ "$output" = "" ]
}

@test "both removal of two input lines" {
    runWithInput $'new signin\nnewer pin' longestCommon --remove-both
    [ $status -eq 0 ]
    [ "$output" = " sign
er p" ]
}

@test "both removal of three input lines" {
    runWithInput $'stain\nsin\nsignin' longestCommon --remove-both
    [ $status -eq 0 ]
    [ "$output" = "ta

ign" ]
}

@test "both removal of three completely different input lines is identical to input and returns 99" {
    runWithInput $'loo\nfox\nfoony' longestCommon --remove-both
    [ $status -eq 99 ]
    [ "$output" = $'loo\nfox\nfoony' ]
}

@test "both removal of two identical prefixes and suffixes with different text in between" {
    runWithInput $'foo-bar\nfooXbar' longestCommon --remove-both
    [ $status -eq 0 ]
    [ "$output" = "-
X" ]
}

@test "both removal of two identical prefixes and suffixes partially with different text in between" {
    runWithInput $'foo-bar\nfoobar' longestCommon --remove-both
    [ $status -eq 0 ]
    [ "$output" = "-" ]
}

@test "both removal of two repeat-character prefixes and suffixes with one interrupted" {
    runWithInput $'oooooo\nooooXoo' longestCommon --remove-both
    [ $status -eq 0 ]
    [ "$output" = "
X" ]
}

@test "both removal of three repeat-character prefixes and suffixes with two interrupted differently" {
    runWithInput $'oooooo\nooooXoo\noXooooo' longestCommon --remove-both
    [ $status -eq 0 ]
    [ "$output" = "ooo
oooX
Xooo" ]
}
