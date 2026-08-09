#!/usr/bin/env bats

load fixture

@test "no arguments prints message and usage instructions" {
    run -2 pathnameGlobToGlob
    assert_line -n -1 -e '^Usage:'
}

@test "-h prints long usage help" {
    run -0 pathnameGlobToGlob -h
    refute_line -n 0 -e '^Usage:'
}
