#!/usr/bin/env bats

load fixture

@test "list 2 first and 2 last lines from two files with silent" {
    run -0 headtail --silent --lines 2 "${BATS_TEST_DIRNAME}/counts" "${BATS_TEST_DIRNAME}/louds"
    assert_output - <<'EOF'
one
two
four
five
ONE
TWO
ELEVEN
TWELVE
EOF
}
