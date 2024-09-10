#!/usr/bin/env bats

@test "merge with empty args keeps empty output by default" {
    run mergeLists '' bar baz baz '' quux ''
    [ $status -eq 0 ]
    [ "$output" = $'\nbar\nbaz\nquux' ]
}
