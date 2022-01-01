#!/usr/bin/env bats

@test "three counts with a custom joiner " {
    run printCounts --joiner '+' 2 cat 2 dog 2 horse
    [ $status -eq 0 ]
    [ "$output" = "2 cats+2 dogs+2 horses" ]
}
