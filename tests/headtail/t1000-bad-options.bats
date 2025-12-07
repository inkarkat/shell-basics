#!/usr/bin/env bats

load fixture

@test "unknown option prints an error message" {
    run -2 headtail --does-not-exist
    assert_line -n 0 "ERROR: Unknown option \"--does-not-exist\"!"
    assert_line -n -2 -e "^Usage:"
}
