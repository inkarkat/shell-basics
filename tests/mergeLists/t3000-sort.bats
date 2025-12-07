#!/usr/bin/env bats

load fixture

@test "default sort args" {
    run -0 mergeLists --sort foo bar baz baz foo quux foo
    assert_output $'bar\nbaz\nfoo\nquux'
}

@test "numeric sort args" {
    run -0 mergeLists --numeric-sort --reverse 11 3 9 9 7 4 3 1
    assert_output $'11\n9\n7\n4\n3\n1'
}
