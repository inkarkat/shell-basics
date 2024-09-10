#!/usr/bin/env bats

@test "split first on - and merge args" {
    run mergeLists --field-separator - foo-bar-baz baz foo quux foo
    [ $status -eq 0 ]
    [ "$output" = $'foo-bar-baz-quux' ]
}

@test "split all on - and merge args" {
    run mergeLists --field-separator - foo-bar-baz baz-foo quux-foo
    [ $status -eq 0 ]
    [ "$output" = $'foo-bar-baz-quux' ]
}

@test "split single on - and merge args" {
    run mergeLists --field-separator - foo-bar-baz-baz-foo-quux-foo
    [ $status -eq 0 ]
    [ "$output" = $'foo-bar-baz-quux' ]
}

@test "split single on space and merge args" {
    run mergeLists --field-separator ' ' 'foo bar baz baz foo quux foo'
    [ $status -eq 0 ]
    [ "$output" = $'foo bar baz quux' ]
}

@test "split single on tabs and merge args" {
    run mergeLists --field-separator $'\t' $'foo here\tbar\tbaz\tbaz\tfoo here\tquux\tfoo here'
    [ $status -eq 0 ]
    [ "$output" = $'foo here\tbar\tbaz\tquux' ]
}

@test "split and merge args into a single result" {
    run mergeLists --field-separator - foo-foo foo
    [ $status -eq 0 ]
    [ "$output" = 'foo' ]
}
