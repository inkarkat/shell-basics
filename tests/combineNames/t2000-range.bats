#!/usr/bin/env bats

load fixture

@test "range of just one name" {
    run -0 combineNames --range foo1.txt
    assert_output 'foo1.txt'
}

@test "range of 9 foos" {
    run -0 combineNames --range foo{1..9}.txt
    assert_output 'foo1…9.txt'
}
