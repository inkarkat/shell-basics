#!/usr/bin/env bats

load fixture

@test "list all but the 1 first and 1 last lines from file" {
    run -0 headtail --lines -1 "${BATS_TEST_DIRNAME}/louds"
    assert_output - <<'EOF'
TWO
THREE
FOUR
FIVE
SIX
SEVEN
EIGHT
NINE
TEN
ELEVEN
EOF
}

@test "list all but 5 first and 5 last lines from stdin" {
    run -0 headtail --lines -5 < "${BATS_TEST_DIRNAME}/louds"
    assert_output - <<'EOF'
SIX
SEVEN
EOF
}

@test "list all but 2 first and 2 last lines resulting in a single line" {
    run -0 headtail --lines -2 "${BATS_TEST_DIRNAME}/counts"
    assert_output 'three'
}

@test "list all but 3 first and 3 last lines which is more than file has" {
    run -0 headtail --lines -3 "${BATS_TEST_DIRNAME}/counts"
    assert_output ''
}

@test "list all but 0 first and 0 last lines from file prints the whole file" {
    run -0 headtail --lines -0 "${BATS_TEST_DIRNAME}/counts"
    assert_output - < "${BATS_TEST_DIRNAME}/counts"
}
