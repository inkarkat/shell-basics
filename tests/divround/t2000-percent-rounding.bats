#!/usr/bin/env bats

@test "percent rounding" {
    run divround 50
    [ $status -eq 0 ]
    [ "$output" = "0.5" ]

    run divround 1234
    [ "$output" = "12.3" ]

    run divround 1235
    [ "$output" = "12.4" ]

    run divround 1236
    [ "$output" = "12.4" ]

    run divround 99994
    [ "$output" = "999.9" ]

    run divround 99995
    [ "$output" = "1000" ]
}

@test "round off with thousands" {
    run divround 123456
    [ "$output" = "1235" ]

    run divround 1234567
    [ "$output" = "12346" ]

    run divround 12345678
    [ "$output" = "123457" ]

    run divround 123456789
    [ "$output" = "1234568" ]
}
