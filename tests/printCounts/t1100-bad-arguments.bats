#!/usr/bin/env bats

@test "missing what does not print any counts but usage" {
    run printCounts 2 cat 1 dog 3
    [ $status -eq 2 ]
    [ "${lines[0]}" = "ERROR: Missing WHAT[,PLURAL-WHAT]." ]
    [ "${lines[-2]%% *}" = "Usage:" ]
}
