#!/usr/bin/env bats

load fixture

@test "split first on - and merge args" {
    run -0 mergeLists --field-separator - foo-bar-baz baz foo quux foo
    assert_output $'foo-bar-baz-quux'
}

@test "split all on - and merge args" {
    run -0 mergeLists --field-separator - foo-bar-baz baz-foo quux-foo
    assert_output $'foo-bar-baz-quux'
}

@test "split single on - and merge args" {
    run -0 mergeLists --field-separator - foo-bar-baz-baz-foo-quux-foo
    assert_output $'foo-bar-baz-quux'
}

@test "split single on space and merge args" {
    run -0 mergeLists --field-separator ' ' 'foo bar baz baz foo quux foo'
    assert_output $'foo bar baz quux'
}

@test "split single on tabs and merge args" {
    run -0 mergeLists --field-separator $'\t' $'foo here\tbar\tbaz\tbaz\tfoo here\tquux\tfoo here'
    assert_output $'foo here\tbar\tbaz\tquux'
}

@test "split and merge args into a single result" {
    run -0 mergeLists --field-separator - foo-foo foo
    assert_output 'foo'
}
