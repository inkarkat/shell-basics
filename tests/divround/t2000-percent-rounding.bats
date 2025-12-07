#!/usr/bin/env bats

load fixture

@test "percent rounding" {
    run -0 divround 50
    assert_output '0.5'

    run divround 1234
    assert_output '12.3'

    run divround 1235
    assert_output '12.4'

    run divround 1236
    assert_output '12.4'

    run divround 99994
    assert_output '999.9'

    run divround 99995
    assert_output '1000'
}

@test "round off with thousands" {
    run divround 123456
    assert_output '1235'

    run divround 1234567
    assert_output '12346'

    run divround 12345678
    assert_output '123457'

    run divround 123456789
    assert_output '1234568'
}

@test "round off with large round numbers" {
    run divround 50000
    assert_output '500'

    run divround 500000
    assert_output '5000'

    run divround 5000000
    assert_output '50000'

    run divround 50000000
    assert_output '500000'

    run divround 500000000
    assert_output '5000000'

    run divround 5000000000
    assert_output '50000000'

    run divround 50000000000
    assert_output '500000000'
}
