#!/usr/bin/env bats

load fixture

@test "search for single line regexp in non-existing file returns 2 and error message" {
    run multilinegrep --basic-regexp '.' doesNotExist.txt
    [ $status -eq 2 ]
    [ "$output" = "sed: can't read doesNotExist.txt: No such file or directory" ]
}

@test "search for single line regexp in existing and non-existing file returns 2, error message and matched line" {
    run multilinegrep --basic-regexp 'Start' "$INPUT" doesNotExist.txt
    [ $status -eq 2 ]
    [ "$output" = "sed: can't read doesNotExist.txt: No such file or directory
Start" ]
}
