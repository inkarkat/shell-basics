#!/usr/bin/env bats

@test "begin sequence" {
    run joinWith --begin-sequence \; ', ' ' and ' ' or ' \; 1 2 3 4 5 6 7 8 9
    [ $status -eq 0 ]
    [ "$output" = "1, 2 and 3 or 4 5 6 7 8 9" ]
}

@test "begin sequence longer than input" {
    run joinWith --begin-sequence \; ', ' ' and ' ' or ' \; 1 2 3
    [ $status -eq 0 ]
    [ "$output" = "1, 2 and 3" ]
}

@test "end sequence" {
    run joinWith --end-sequence \; ': ' ' to ' ' until ' \; 1 2 3 4 5 6 7 8 9
    [ $status -eq 0 ]
    [ "$output" = "1 2 3 4 5 6: 7 to 8 until 9" ]
}

@test "end sequence longer than input" {
    run joinWith --end-sequence \; ': ' ' to ' ' until ' \; 8 9
    [ $status -eq 0 ]
    [ "$output" = "8 until 9" ]
}

@test "begin sequence and end sequence" {
    run joinWith --begin-sequence \; ', ' ' and ' ' or ' \; --end-sequence \; ': ' ' to ' ' until ' \; 1 2 3 4 5 6 7 8 9
    [ $status -eq 0 ]
    [ "$output" = "1, 2 and 3 or 4 5 6: 7 to 8 until 9" ]
}

@test "overlapping begin and end sequences" {
    run joinWith --begin-sequence \; ', ' ' and ' ' or ' \; --end-sequence \; ': ' ' to ' ' until ' \; 1 2 3 4 5 6
    [ $status -eq 0 ]
    [ "$output" = "1, 2 and 3 or 4 to 5 until 6" ]
}
