#!/usr/bin/env bats

load fixture

setup() {
    TMPFILE=/tmp/bats-test-headtail-tempfile
    cp -- "${BATS_TEST_DIRNAME}/louds" "$TMPFILE" || skip "cannot create $TMPFILE"
}

@test "list 2 first and 2 last lines from tempfile with custom cutline containing filespec" {
    COLUMNS=60 run -0 headtail --lines 2 --separator-cut-what 'truncated {F}' "$TMPFILE"
    assert_output - <<'EOF'
ONE
TWO
~~~~~ [truncated /tmp/bats-test-headtail-tempfile] ~~~~~
ELEVEN
TWELVE
EOF
}

@test "list 2 first and 2 last lines from tempfile with custom cutline containing count and filespec" {
    COLUMNS=30 run -0 headtail --lines 2 --separator-cut-what '{} lines truncated from {F}' "$TMPFILE"
    assert_output - <<'EOF'
ONE
TWO
[8 lines truncated from /tmp/bats-test-headtail-tempfile]
ELEVEN
TWELVE
EOF
}

@test "list 2 first and 2 last lines from standard input with file cutline containing count and filespec" {
    COLUMNS=30 run -0 headtail --lines 2 --separator-cutline-file < "$TMPFILE"
    assert_output -e - <<'EOF'
^ONE
TWO
\[8 lines omitted from /tmp/headtail-.*\]
ELEVEN
TWELVE$
EOF
}

@test "temp file from file cutline from standard input persists after invocation" {
    COLUMNS=30 run -0 headtail --lines 2 --separator-cutline-file < "$TMPFILE"
    [[ "${lines[2]}" =~ ^\[8\ lines\ omitted\ from\ (/tmp/headtail-.*)\]$ ]]
    tempfile="${BASH_REMATCH[1]}"
    assert_file_exists "$tempfile"
    assert_files_equal "$tempfile" "$TMPFILE"
}

@test "list first and last line from files and input with file cutline containing count and filespec" {
    COLUMNS=30 run -0 headtail --lines 1 --separator-cutline-file "${BATS_TEST_DIRNAME}/counts" - "${BATS_TEST_DIRNAME}/louds" < "$TMPFILE"
    assert_output -e - <<EOF
^==> ${BATS_TEST_DIRNAME}/counts <==
one
\[3 lines omitted from ${BATS_TEST_DIRNAME}/counts\]
five

==> /tmp/headtail-.* <==
ONE
\[10 lines omitted from /tmp/headtail-.*\]
TWELVE

==> ${BATS_TEST_DIRNAME}/louds <==
ONE
\[10 lines omitted from ${BATS_TEST_DIRNAME}/louds\]
TWELVE$
EOF
}
