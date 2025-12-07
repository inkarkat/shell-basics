#!/usr/bin/env bats

load fixture

@test "merge with empty args keeps empty output by default" {
    run -0 mergeLists '' bar baz baz '' quux ''
    assert_output $'\nbar\nbaz\nquux'
}

@test "merge with omitted empty args" {
    run -0 mergeLists --omit-empty '' bar baz baz '' quux ''
    assert_output $'bar\nbaz\nquux'
}

@test "merge with omitted empty split args" {
    run -0 mergeLists --omit-empty --field-separator , '' bar,,,baz baz '' ,quux ''
    assert_output 'bar,baz,quux'
}
