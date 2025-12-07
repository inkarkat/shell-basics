#!/usr/bin/env bats

load fixture

@test "merge args" {
    run -0 mergeLists foo bar baz baz foo quux foo
    assert_output $'foo\nbar\nbaz\nquux'
}

@test "merge args into a single result" {
    run -0 mergeLists foo foo foo
    assert_output 'foo'
}
