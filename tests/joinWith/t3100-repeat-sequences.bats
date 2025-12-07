#!/usr/bin/env bats

load fixture

@test "repeat sequence" {
    run -0 joinWith --repeat-sequence \; + - = ' ' \; 1 2 3 4 5 6 7 8 9
    assert_output '1+2-3=4 5+6-7=8 9'
}

@test "repeat sequence starts after begin sequence" {
    run joinWith \
	    --repeat-sequence \; + - = ' ' \; \
	    --begin-sequence \; '*' ':' ' ' \; \
	    1 2 3 4 5 6 7 8 9 10 11 12
    assert_success
    assert_output '1*2:3 4+5-6=7 8+9-10=11 12'
}

@test "repeat sequence and end sequence" {
    run joinWith \
	    --repeat-sequence \; + - = ' ' \; \
	    --end-sequence \; '. ' ' and ' ' or ' \; \
	    1 2 3 4 5 6 7 8 9 10 11 12
    assert_success
    assert_output '1+2-3=4 5+6-7=8 9. 10 and 11 or 12'
}

@test "repeat sequence with begin and end sequences" {
    run joinWith \
	    --repeat-sequence \; + - = ' ' \; \
	    --begin-sequence \; '*' ':' ' ' \; \
	    --end-sequence \; '. ' ' and ' ' or ' \; \
	    1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18
    assert_success
    assert_output '1*2:3 4+5-6=7 8+9-10=11 12+13-14=15. 16 and 17 or 18'
}
