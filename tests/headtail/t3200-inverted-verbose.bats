#!/usr/bin/env bats

load fixture

@test "list all but 2 first and 2 last lines from single file with verbose" {
    run -0 headtail --verbose --lines -2 "${BATS_TEST_DIRNAME}/counts"
    assert_output - <<EOF
==> ${BATS_TEST_DIRNAME}/counts <==
three
EOF
}

@test "list all but 2 first and 2 last lines from two files is verbose by default" {
    run -0 headtail --verbose --lines -2 "${BATS_TEST_DIRNAME}/counts" "${BATS_TEST_DIRNAME}/louds"
    assert_output - <<EOF
==> ${BATS_TEST_DIRNAME}/counts <==
three

==> ${BATS_TEST_DIRNAME}/louds <==
THREE
FOUR
FIVE
SIX
SEVEN
EIGHT
NINE
TEN
EOF
}

@test "list all but 0 first and 0 last lines from two files is verbose by default" {
    run -0 headtail --verbose --lines -0 "${BATS_TEST_DIRNAME}/counts" "${BATS_TEST_DIRNAME}/louds"
    assert_output - <<EOF
==> ${BATS_TEST_DIRNAME}/counts <==
$(cat "${BATS_TEST_DIRNAME}/counts")

==> ${BATS_TEST_DIRNAME}/louds <==
$(cat "${BATS_TEST_DIRNAME}/louds")
EOF
}

@test "list all but 0 first and 0 last lines from single file with verbose" {
    run -0 headtail --verbose --lines -0 "${BATS_TEST_DIRNAME}/counts"
    assert_output - <<EOF
==> ${BATS_TEST_DIRNAME}/counts <==
$(cat "${BATS_TEST_DIRNAME}/counts")
EOF
}
