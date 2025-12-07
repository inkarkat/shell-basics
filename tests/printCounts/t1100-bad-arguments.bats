#!/usr/bin/env bats

load fixture

@test "missing what does not print any counts but usage" {
    run -2 printCounts 2 cat 1 dog 3
    assert_line -n 0 "ERROR: Missing WHAT[,PLURAL-WHAT]."
    assert_line -n -2 -e "^Usage:"
}
