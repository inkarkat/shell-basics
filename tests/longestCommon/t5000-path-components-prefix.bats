#!/usr/bin/env bats

load fixture

@test "path prefix of empty input is empty" {
    runWithInput '' longestCommon --get-prefix --path-components
    [ $status -eq 0 ]
    [ "$output" = "" ]
}

@test "path prefix of single input line is that input line" {
    runWithInput 'foo bar' longestCommon --get-prefix --path-components
    [ $status -eq 0 ]
    [ "$output" = "foo bar" ]
}

@test "path prefix of two identical input lines is the entire input line" {
    runWithInput $'foo bar\nfoo bar' longestCommon --get-prefix --path-components
    [ $status -eq 0 ]
    [ "$output" = "foo bar" ]
}

@test "absolute path component prefix of two input lines" {
    runWithInput $'/path/to/foo\n/path/to/forbidden/bar' longestCommon --get-prefix --path-components
    [ $status -eq 0 ]
    [ "$output" = "/path/to" ]
}

@test "absolute path component prefix of two identical input lines" {
    runWithInput $'/path/to/foo\n/path/to/foo' longestCommon --get-prefix --path-components
    [ $status -eq 0 ]
    [ "$output" = "/path/to/foo" ]
}

@test "absolute path component prefix of two almost identical input lines, just one final slash missing from one" {
    runWithInput $'/path/to/foo\n/path/to/foo/' longestCommon --get-prefix --path-components
    [ $status -eq 0 ]
    [ "$output" = "/path/to/foo" ]
}

@test "relative path component prefix of two input lines" {
    runWithInput $'./path/to/foo\n./path/to/forbidden/bar' longestCommon --get-prefix --path-components
    [ $status -eq 0 ]
    [ "$output" = "./path/to" ]
}

@test "mix of path separator and inner is ignored" {
    runWithInput $'/path/towards/foo/bar\n/path/to/foo/bar' longestCommon --get-prefix --path-components
    [ $status -eq 0 ]
    [ "$output" = "/path" ]
}
