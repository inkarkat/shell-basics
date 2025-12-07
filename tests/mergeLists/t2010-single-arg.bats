#!/usr/bin/env bats

load fixture

@test "merge single arg" {
    run -0 mergeLists foo
    assert_output 'foo'
}

@test "merge no args" {
    run -0 mergeLists --
    assert_output ''
}
