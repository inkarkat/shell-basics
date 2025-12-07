#!/usr/bin/env bats

load fixture

@test "-h prints long usage help" {
    run -0 printCounts -h
    refute_line -n 0 -e '^Usage:'
    assert_line -n 1 -e '^Usage:'
}
