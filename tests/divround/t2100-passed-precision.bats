#!/usr/bin/env bats

load fixture

@test "precision rounding" {
    run divround 1234 1
    assert_output '12.3'

    run divround 1234 0
    assert_output '123'

    run divround 1234 2
    assert_output '1.23'

    run divround 1234 3
    assert_output '0.123'

    run divround 1234 4
    assert_output '0'
}

@test "round off with thousands" {
    run divround 123456 1
    assert_output '1235'

    run divround 1234567 2
    assert_output '1235'

    run divround 12345678 3
    assert_output '1235'

    run divround 123456789 4
    assert_output '1235'

    run divround 1234567890 5
    assert_output '1235'
}
