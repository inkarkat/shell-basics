#!/usr/bin/env bats

load fixture

@test "three counts with a custom joiner " {
    run -0 printCounts --joiner '+' 2 cat 2 dog 2 horse
    assert_output '2 cats+2 dogs+2 horses'
}
