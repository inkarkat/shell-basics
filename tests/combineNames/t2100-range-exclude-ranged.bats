#!/usr/bin/env bats

load fixture

@test "range of 9 foos and ranges excludes the latter" {
    run -0 combineNames --range --exclude-ranged foo2…4.txt foo{1..5}.txt foo5…6.txt foo{6..9}.txt foo7…9.txt
    assert_output 'foo1…9.txt'
}
