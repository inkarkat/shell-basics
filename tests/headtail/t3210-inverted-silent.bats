#!/usr/bin/env bats

load fixture

@test "list all but 2 first and 2 last lines from two files with silent" {
    run -0 headtail --silent --lines -2 "${BATS_TEST_DIRNAME}/counts" "${BATS_TEST_DIRNAME}/louds"
    assert_output - <<'EOF'
three
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
