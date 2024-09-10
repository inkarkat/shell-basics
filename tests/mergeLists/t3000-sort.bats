#!/usr/bin/env bats

@test "default sort args" {
    run mergeLists --sort foo bar baz baz foo quux foo
    [ $status -eq 0 ]
    [ "$output" = $'bar\nbaz\nfoo\nquux' ]
}

@test "numeric sort args" {
    run mergeLists --numeric-sort --reverse 11 3 9 9 7 4 3 1
    [ $status -eq 0 ]
    [ "$output" = $'11\n9\n7\n4\n3\n1' ]
}
