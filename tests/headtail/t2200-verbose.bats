#!/usr/bin/env bats

load fixture

@test "list 2 first and 2 last lines from single file with verbose" {
    run -0 headtail --verbose --lines 2 "${BATS_TEST_DIRNAME}/counts"
    assert_output - <<EOF
==> ${BATS_TEST_DIRNAME}/counts <==
one
two
four
five
EOF
}

@test "list 2 first and 2 last lines from two files is verbose by default" {
    run -0 headtail --verbose --lines 2 "${BATS_TEST_DIRNAME}/counts" "${BATS_TEST_DIRNAME}/louds"
    assert_output - <<EOF
==> ${BATS_TEST_DIRNAME}/counts <==
one
two
four
five

==> ${BATS_TEST_DIRNAME}/louds <==
ONE
TWO
ELEVEN
TWELVE
EOF
}

@test "list 0 first and 0 last lines from two files is verbose by default" {
    run -0 headtail --verbose --lines 0 "${BATS_TEST_DIRNAME}/counts" "${BATS_TEST_DIRNAME}/louds"
    assert_output - <<EOF
==> ${BATS_TEST_DIRNAME}/counts <==

==> ${BATS_TEST_DIRNAME}/louds <==
EOF
}

@test "list 0 first and 0 last lines from single file with verbose" {
    run -0 headtail --verbose --lines 0 "${BATS_TEST_DIRNAME}/counts"
    assert_output "==> ${BATS_TEST_DIRNAME}/counts <=="
}
