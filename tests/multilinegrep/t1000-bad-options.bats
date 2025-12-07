#!/usr/bin/env bats

load fixture

@test "unknown option prints an error message" {
    run -2 multilinegrep --does-not-exist
    assert_line -n 0 "ERROR: Unknown option \"--does-not-exist\"!"
    assert_line -n -2 -e "^Usage:"
}

@test "combinatation of --extended-regexp and --fixed-strings prints an error message" {
    run -2 multilinegrep --extended-regexp --fixed-strings foo
    assert_line -n 0 "ERROR: Only one of -E|--extended-regexp, -F|--fixed-strings, -G|--basic-regexp can be passed."
    assert_line -n -2 -e "^Usage:"
}

@test "combinatation of --extended-regexp and --basic-regexp prints an error message" {
    run -2 multilinegrep --extended-regexp --basic-regexp foo
    assert_line -n 0 "ERROR: Only one of -E|--extended-regexp, -F|--fixed-strings, -G|--basic-regexp can be passed."
    assert_line -n -2 -e "^Usage:"
}

@test "combinatation of --basic-regexp and --fixed-strings prints an error message" {
    run -2 multilinegrep --basic-regexp --fixed-strings foo
    assert_line -n 0 "ERROR: Only one of -E|--extended-regexp, -F|--fixed-strings, -G|--basic-regexp can be passed."
    assert_line -n -2 -e "^Usage:"
}

@test "no pattern prints usage" {
    run -2 multilinegrep -- /dev/null
    assert_line -n -2 -e "^Usage:"
}
