#!/usr/bin/env bats

load fixture

@test "begin sequence" {
    run -0 joinWith --begin-sequence \; ', ' ' and ' ' or ' \; 1 2 3 4 5 6 7 8 9
    assert_output '1, 2 and 3 or 4 5 6 7 8 9'
}

@test "begin sequence longer than input" {
    run -0 joinWith --begin-sequence \; ', ' ' and ' ' or ' \; 1 2 3
    assert_output '1, 2 and 3'
}

@test "end sequence" {
    run -0 joinWith --end-sequence \; ': ' ' to ' ' until ' \; 1 2 3 4 5 6 7 8 9
    assert_output '1 2 3 4 5 6: 7 to 8 until 9'
}

@test "end sequence longer than input" {
    run -0 joinWith --end-sequence \; ': ' ' to ' ' until ' \; 8 9
    assert_output '8 until 9'
}

@test "begin sequence and end sequence" {
    run -0 joinWith --begin-sequence \; ', ' ' and ' ' or ' \; --end-sequence \; ': ' ' to ' ' until ' \; 1 2 3 4 5 6 7 8 9
    assert_output '1, 2 and 3 or 4 5 6: 7 to 8 until 9'
}

@test "overlapping begin and end sequences" {
    run -0 joinWith --begin-sequence \; ', ' ' and ' ' or ' \; --end-sequence \; ': ' ' to ' ' until ' \; 1 2 3 4 5 6
    assert_output '1, 2 and 3 or 4 to 5 until 6'
}
