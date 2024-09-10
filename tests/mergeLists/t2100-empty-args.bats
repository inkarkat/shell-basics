#!/usr/bin/env bats

@test "merge with empty args keeps empty output by default" {
    run mergeLists '' bar baz baz '' quux ''
    [ $status -eq 0 ]
    [ "$output" = $'\nbar\nbaz\nquux' ]
}

@test "merge with omitted empty args" {
    run mergeLists --omit-empty '' bar baz baz '' quux ''
    [ $status -eq 0 ]
    [ "$output" = $'bar\nbaz\nquux' ]
}

@test "merge with omitted empty split args" {
    run mergeLists --omit-empty --field-separator , '' bar,,,baz baz '' ,quux ''
    [ $status -eq 0 ]
    [ "$output" = 'bar,baz,quux' ]
}
