#!/usr/bin/env bats

@test "merge args" {
    run mergeLists foo bar baz baz foo quux foo
    [ $status -eq 0 ]
    [ "$output" = $'foo\nbar\nbaz\nquux' ]
}

@test "merge args into a single result" {
    run mergeLists foo foo foo
    [ $status -eq 0 ]
    [ "$output" = 'foo' ]
}
