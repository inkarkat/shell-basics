#!/usr/bin/env bats

load fixture

@test "list 2 first and 2 last lines from standard input with cutline" {
    COLUMNS=40 run -0 headtail --lines 2 --separator-cutline < "${BATS_TEST_DIRNAME}/louds"
    assert_output - <<'EOF'
ONE
TWO
~~~~~~~~~~~~~~~~ [...] ~~~~~~~~~~~~~~~~
ELEVEN
TWELVE
EOF
}

@test "list 2 first and 2 last lines from standard input with custom cutline" {
    COLUMNS=40 run -0 headtail --lines 2 --separator-cut-what 'truncated' < "${BATS_TEST_DIRNAME}/louds"
    assert_output - <<'EOF'
ONE
TWO
~~~~~~~~~~~~~ [truncated] ~~~~~~~~~~~~~
ELEVEN
TWELVE
EOF
}

@test "list 2 first and 2 last lines from standard input with custom cutline containing count" {
    COLUMNS=40 run -0 headtail --lines 2 --separator-cut-what '{} lines truncated' < "${BATS_TEST_DIRNAME}/louds"
    assert_output - <<'EOF'
ONE
TWO
~~~~~~~~~ [8 lines truncated] ~~~~~~~~~
ELEVEN
TWELVE
EOF
}

@test "list 2 first and 2 last lines from 104 input lines with custom cutline containing count" {
    COLUMNS=40 run -0 headtail --lines 2 --separator-cut-what '{} lines truncated' < <(seq 1 104)
    assert_output - <<'EOF'
1
2
~~~~~~~~ [100 lines truncated] ~~~~~~~~
103
104
EOF
}

@test "list 2 first and 2 last lines from 1004 input lines with custom cutline containing count" {
    COLUMNS=40 run -0 headtail --lines 2 --separator-cut-what '{} lines truncated' < <(seq 1 1004)
    assert_output - <<'EOF'
1
2
~~~~~~~~ [1000 lines truncated] ~~~~~~~~
1003
1004
EOF
}

@test "list 2 first and 2 last lines from 10004 input lines with custom cutline containing count" {
    COLUMNS=40 run -0 headtail --lines 2 --separator-cut-what '{} lines truncated' < <(seq 1 10004)
    assert_output - <<'EOF'
1
2
~~~~~~~ [10000 lines truncated] ~~~~~~~
10003
10004
EOF
}

@test "list 2 first and 2 last lines from standard input with custom cutline containing filespec" {
    COLUMNS=60 run -0 headtail --lines 2 --separator-cut-what 'truncated {F}' < "${BATS_TEST_DIRNAME}/louds"
    assert_output - <<'EOF'
ONE
TWO
~~~~~~~~~~~~~~~~~~~ [truncated input] ~~~~~~~~~~~~~~~~~~~
ELEVEN
TWELVE
EOF
}

@test "list 2 first and 2 last lines from explicitly passed standard input with custom cutline containing filespec" {
    COLUMNS=60 run -0 headtail --lines 2 --separator-cut-what 'truncated {F}' - < "${BATS_TEST_DIRNAME}/louds"
    assert_output - <<'EOF'
ONE
TWO
~~~~~~~~~~~~~~~~~~~ [truncated input] ~~~~~~~~~~~~~~~~~~~
ELEVEN
TWELVE
EOF
}

@test "list first and last line from files with file cutline containing count and filespec" {
    COLUMNS=30 run -0 headtail --lines 1 --separator-cutline-file "${BATS_TEST_DIRNAME}/counts" "${BATS_TEST_DIRNAME}/louds"
    assert_output - <<EOF
==> ${BATS_TEST_DIRNAME}/counts <==
one
[3 lines omitted from ${BATS_TEST_DIRNAME}/counts]
five

==> ${BATS_TEST_DIRNAME}/louds <==
ONE
[10 lines omitted from ${BATS_TEST_DIRNAME}/louds]
TWELVE
EOF
}
