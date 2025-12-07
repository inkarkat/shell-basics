#!/usr/bin/env bats

load fixture

@test "merge args and output with - separator" {
    run -0 mergeLists --output-separator - foo bar baz baz foo quux foo
    assert_output 'foo-bar-baz-quux'
}

@test "merge args into a single result and output with - separator" {
    run -0 mergeLists --output-separator - foo foo foo
    assert_output 'foo'
}

@test "merge args and output with backslash separator" {
    run -0 mergeLists --output-separator \\ foo bar baz baz foo quux foo
    assert_output 'foo\bar\baz\quux'
}

@test "merge args and output with tab separator" {
    run -0 mergeLists --output-separator $'\t' foo bar baz baz foo quux foo
    assert_output $'foo\tbar\tbaz\tquux'
}

@test "merge args and output with escaped tab separator" {
    run -0 mergeLists --output-separator '\t' foo bar baz baz foo quux foo
    assert_output $'foo\tbar\tbaz\tquux'
}

@test "merge args and output with newline separator" {
    run -0 mergeLists --output-separator $'\n' foo bar baz baz foo quux foo
    assert_output $'foo\nbar\nbaz\nquux'
}

@test "merge args and output with escaped newline separator" {
    run -0 mergeLists --output-separator '\n' foo bar baz baz foo quux foo
    assert_output $'foo\nbar\nbaz\nquux'
}

@test "merge args and output with double newline separator" {
    run -0 mergeLists --output-separator $'\n\n' foo bar baz baz foo quux foo
    assert_output $'foo\n\nbar\n\nbaz\n\nquux'
}
