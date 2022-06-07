#!/usr/bin/env bats

load fixture

@test "path suffix of empty input is empty" {
    runWithInput '' longestCommon --get-suffix --path-components
    [ $status -eq 0 ]
    [ "$output" = "" ]
}

@test "path suffix of single input line is that input line" {
    runWithInput 'foo bar' longestCommon --get-suffix --path-components
    [ $status -eq 0 ]
    [ "$output" = "foo bar" ]
}

@test "path suffix of two identical input lines is the entire input line" {
    runWithInput $'foo bar\nfoo bar' longestCommon --get-suffix --path-components
    [ $status -eq 0 ]
    [ "$output" = "foo bar" ]
}

@test "absolute path component suffix of two input lines" {
    runWithInput $'/etc/kellog/foo/bar\n/var/log/foo/bar' longestCommon --get-suffix --path-components
    [ $status -eq 0 ]
    [ "$output" = "foo/bar" ]
}

@test "absolute path component suffix of two identical input lines" {
    runWithInput $'/path/to/foo\n/path/to/foo' longestCommon --get-suffix --path-components
    [ $status -eq 0 ]
    [ "$output" = "/path/to/foo" ]
}

@test "absolute path component suffix of two almost identical input lines, just one leading slash missing from one" {
    runWithInput $'path/to/foo\n/path/to/foo' longestCommon --get-suffix --path-components
    [ $status -eq 0 ]
    [ "$output" = "path/to/foo" ]
}

@test "mix of path separator and inner is ignored" {
    runWithInput $'/path/towards/foo/bar\n/path/to/foo/bar' longestCommon --get-suffix --path-components
    [ $status -eq 0 ]
    [ "$output" = "foo/bar" ]
}

@test "remove path suffix of single input line is empty" {
    runWithInput 'foo bar' longestCommon --remove-suffix --path-components
    [ $status -eq 0 ]
    [ "$output" = "" ]
}

@test "remove absolute path component suffix of two input lines" {
    runWithInput $'/etc/kellog/foo/bar\n/var/log/foo/bar' longestCommon --remove-suffix --path-components
    [ $status -eq 0 ]
    [ "$output" = "/etc/kellog
/var/log" ]
}
