#!/usr/bin/env bats

@test "merge args and output with - separator" {
    run mergeLists --output-separator - foo bar baz baz foo quux foo
    [ $status -eq 0 ]
    [ "$output" = 'foo-bar-baz-quux' ]
}

@test "merge args into a single result and output with - separator" {
    run mergeLists --output-separator - foo foo foo
    [ $status -eq 0 ]
    [ "$output" = 'foo' ]
}

@test "merge args and output with backslash separator" {
    run mergeLists --output-separator \\ foo bar baz baz foo quux foo
    [ $status -eq 0 ]
    [ "$output" = 'foo\bar\baz\quux' ]
}

@test "merge args and output with tab separator" {
    run mergeLists --output-separator $'\t' foo bar baz baz foo quux foo
    [ $status -eq 0 ]
    [ "$output" = $'foo\tbar\tbaz\tquux' ]
}

@test "merge args and output with escaped tab separator" {
    run mergeLists --output-separator '\t' foo bar baz baz foo quux foo
    [ $status -eq 0 ]
    [ "$output" = $'foo\tbar\tbaz\tquux' ]
}

@test "merge args and output with newline separator" {
    run mergeLists --output-separator $'\n' foo bar baz baz foo quux foo
    [ $status -eq 0 ]
    [ "$output" = $'foo\nbar\nbaz\nquux' ]
}

@test "merge args and output with escaped newline separator" {
    run mergeLists --output-separator '\n' foo bar baz baz foo quux foo
    [ $status -eq 0 ]
    [ "$output" = $'foo\nbar\nbaz\nquux' ]
}

@test "merge args and output with double newline separator" {
    run mergeLists --output-separator $'\n\n' foo bar baz baz foo quux foo
    [ $status -eq 0 ]
    [ "$output" = $'foo\n\nbar\n\nbaz\n\nquux' ]
}
