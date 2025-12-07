#!/usr/bin/env bats

load fixture

@test "search for single line regexp in non-existing file returns 2 and error message" {
    run -2 multilinegrep --basic-regexp '.' doesNotExist.txt
    assert_output -e "doesNotExist.txt: No such file or directory"$
}

@test "search for single line regexp in existing and non-existing file returns 2, error message and matched line" {
    run -2 multilinegrep --basic-regexp 'Start' "$INPUT" doesNotExist.txt
    assert_line -n 0 -e "doesNotExist.txt: No such file or directory"$
    assert_line -n 1 "Start"
}
