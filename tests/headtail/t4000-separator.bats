#!/usr/bin/env bats

load fixture

@test "list 2 first and 2 last lines from standard input with passed separator" {
    run -0 headtail --lines 2 --separator '- XXX -' < <(cat "${BATS_TEST_DIRNAME}/louds")
    assert_output - <<'EOF'
ONE
TWO
- XXX -
ELEVEN
TWELVE
EOF
}

@test "list 2 first and 2 last lines from standard input with empty separator outputs no separator" {
    run -0 headtail --lines 2 --separator '' < <(cat "${BATS_TEST_DIRNAME}/louds")
    assert_output - <<'EOF'
ONE
TWO
ELEVEN
TWELVE
EOF
}
