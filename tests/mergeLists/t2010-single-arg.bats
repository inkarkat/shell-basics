#!/usr/bin/env bats

@test "merge single arg" {
    run mergeLists foo
    [ $status -eq 0 ]
    [ "$output" = 'foo' ]
}

@test "merge no args" {
    run mergeLists --
    [ $status -eq 0 ]
    [ "$output" = '' ]
}
