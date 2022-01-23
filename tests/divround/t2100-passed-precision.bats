#!/usr/bin/env bats

@test "precision rounding" {
    run divround 1234 1
    [ "$output" = "12.3" ]

    run divround 1234 0
    [ "$output" = "123" ]

    run divround 1234 2
    [ "$output" = "1.23" ]

    run divround 1234 3
    [ "$output" = "0.123" ]

    run divround 1234 4
    [ "$output" = "0" ]
}

@test "round off with thousands" {
    run divround 123456 1
    [ "$output" = "1235" ]

    run divround 1234567 2
    [ "$output" = "1235" ]

    run divround 12345678 3
    [ "$output" = "1235" ]

    run divround 123456789 4
    [ "$output" = "1235" ]

    run divround 1234567890 5
    [ "$output" = "1235" ]
}
