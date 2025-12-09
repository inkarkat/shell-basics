#!/usr/bin/env bats

load fixture

@test "list 5 first and 5 last lines from file" {
    run -0 headtail "${BATS_TEST_DIRNAME}/louds"
    assert_output - <<'EOF'
ONE
TWO
THREE
FOUR
FIVE
EIGHT
NINE
TEN
ELEVEN
TWELVE
EOF
}

@test "list 5 first and 5 last lines from stdin" {
    run -0 headtail < "${BATS_TEST_DIRNAME}/louds"
    assert_output - <<'EOF'
ONE
TWO
THREE
FOUR
FIVE
EIGHT
NINE
TEN
ELEVEN
TWELVE
EOF
}
