#!/usr/bin/env bats

load fixture

@test "path both of empty input is empty" {
    runWithInput '' longestCommon --get-both --path-components
    [ $status -eq 0 ]
    [ "$output" = "" ]
}

@test "path both of single input line is that input line, as prefix only" {
    runWithInput 'foo bar' longestCommon --get-both --path-components
    [ $status -eq 0 ]
    [ "$output" = "foo bar" ]
}

@test "path both of two identical input lines is the entire input line, as prefix only" {
    runWithInput $'foo bar\nfoo bar' longestCommon --get-both --path-components
    [ $status -eq 0 ]
    [ "$output" = "foo bar" ]
}

@test "absolute path component both of two input lines" {
    runWithInput $'/opt/etc/kellog/foo/bar\n/opt/var/log/foo/bar' longestCommon --get-both --path-components
    [ $status -eq 0 ]
    [ "$output" = "/opt
foo/bar" ]
}

@test "absolute path component both of two identical input lines" {
    runWithInput $'/path/to/foo\n/path/to/foo' longestCommon --get-both --path-components
    [ $status -eq 0 ]
    [ "$output" = "/path/to/foo" ]
}

@test "remove path both of single input line is empty" {
    runWithInput 'foo bar' longestCommon --remove-both --path-components
    [ $status -eq 0 ]
    [ "$output" = "" ]
}

@test "remove absolute path component both of two input lines" {
    runWithInput $'/opt/etc/kellog/foo/bar\n/opt/var/log/foo/bar' longestCommon --remove-both --path-components
    [ $status -eq 0 ]
    [ "$output" = "etc/kellog
var/log" ]
}
