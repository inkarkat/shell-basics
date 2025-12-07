#!/usr/bin/env bats

load fixture

@test "list 2 first and 2 last lines from standard input with cutline" {
    COLUMNS=40 run -0 headtail --lines 2 --separator-cutline < <(cat "${BATS_TEST_DIRNAME}/louds")
    assert_output - <<'EOF'
ONE
TWO
~~~~~~~~~~~~~~~~ [...] ~~~~~~~~~~~~~~~~
ELEVEN
TWELVE
EOF
}

@test "list 2 first and 2 last lines from standard input with custom cutline" {
    COLUMNS=40 run -0 headtail --lines 2 --separator-cut-what 'truncated' < <(cat "${BATS_TEST_DIRNAME}/louds")
    assert_output - <<'EOF'
ONE
TWO
~~~~~~~~~~~~~ [truncated] ~~~~~~~~~~~~~
ELEVEN
TWELVE
EOF
}

@test "list 2 first and 2 last lines from standard input with custom cutline containing count" {
    COLUMNS=40 run -0 headtail --lines 2 --separator-cut-what '{} lines truncated' < <(cat "${BATS_TEST_DIRNAME}/louds")
    assert_output - <<'EOF'
ONE
TWO
~~~~~~~ [8 lines truncated] ~~~~~~~
ELEVEN
TWELVE
EOF
}
