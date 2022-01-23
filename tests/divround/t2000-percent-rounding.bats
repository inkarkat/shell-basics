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

@test "round off with large round numbers" {
    run divround 50000
    [ "$output" = "500" ]

    run divround 500000
    [ "$output" = "5000" ]

    run divround 5000000
    [ "$output" = "50000" ]

    run divround 50000000
    [ "$output" = "500000" ]

    run divround 500000000
    [ "$output" = "5000000" ]

    run divround 5000000000
    [ "$output" = "50000000" ]

    run divround 50000000000
    [ "$output" = "500000000" ]
}
