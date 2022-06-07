#!/usr/bin/env bats

load fixture

@test "both of empty input is empty" {
    runWithInput '' longestCommon --get-both
    [ $status -eq 0 ]
    [ "$output" = "" ]
}

@test "both of single input line is that input line, as prefix only" {
    runWithInput 'foo bar' longestCommon --get-both
    [ $status -eq 0 ]
    [ "$output" = "foo bar" ]
}

@test "both of two identical input lines is the entire input line, as prefix only" {
    runWithInput $'foo bar\nfoo bar' longestCommon --get-both
    [ $status -eq 0 ]
    [ "$output" = "foo bar" ]
}

@test "both of two input lines" {
    runWithInput $'new signin\nnewer pin' longestCommon --get-both
    [ $status -eq 0 ]
    [ "$output" = "new
in" ]
}

@test "both of three input lines" {
    runWithInput $'stain\nsin\nsignin' longestCommon --get-both
    [ $status -eq 0 ]
    [ "$output" = "s
in" ]
}

@test "both of three completely different input lines is empty and returns 99" {
    runWithInput $'loo\nfox\nfoony' longestCommon --get-both
    [ $status -eq 99 ]
    [ "$output" = "" ]
}

@test "both of two identical prefixes and suffixes with different text in between" {
    runWithInput $'foo-bar\nfooXbar' longestCommon --get-both
    [ $status -eq 0 ]
    [ "$output" = "foo
bar" ]
}

@test "both of two identical prefixes and suffixes partially with different text in between" {
    runWithInput $'foo-bar\nfoobar' longestCommon --get-both
    [ $status -eq 0 ]
    [ "$output" = "foo
bar" ]
}

@test "both of two repeat-character prefixes and suffixes with one interrupted" {
    runWithInput $'oooooo\nooooXoo' longestCommon --get-both
    [ $status -eq 0 ]
    [ "$output" = "oooo
oo" ]
}

@test "both of three repeat-character prefixes and suffixes with two interrupted differently" {
    runWithInput $'oooooo\nooooXoo\noXooooo' longestCommon --get-both
    [ $status -eq 0 ]
    [ "$output" = "o
oo" ]
}
