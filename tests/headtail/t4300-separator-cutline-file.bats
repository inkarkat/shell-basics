#!/usr/bin/env bats

load fixture

@test "list 2 first and 2 last lines from standard input with file cutline containing count and filespec" {
    TMPDIR="$BATS_TEST_TMPDIR" COLUMNS=30 run -0 headtail --lines 2 --separator-cutline-file < "${BATS_TEST_DIRNAME}/louds"
    assert_output -e - <<EOF
^ONE
TWO
\\[8 lines omitted from ${BATS_TEST_TMPDIR}/headtail-.*\\]
ELEVEN
TWELVE\$
EOF
}

@test "temp file from file cutline from standard input persists after invocation" {
    emptydir "$BATS_TEST_TMPDIR"
    TMPDIR="$BATS_TEST_TMPDIR" COLUMNS=30 run -0 headtail --lines 2 --separator-cutline-file < "${BATS_TEST_DIRNAME}/louds"
    assert_line -n 2 -e "^\\[8\\ lines\\ omitted\\ from\\ (${BATS_TEST_TMPDIR}/headtail-.*)\\]\$"
    tempfile="${BASH_REMATCH[1]}"
    run ! emptydir "$BATS_TEST_TMPDIR"
    assert_file_exists "$tempfile"
    assert_files_equal "$tempfile" "${BATS_TEST_DIRNAME}/louds"
}

@test "temp file from file cutline from standard input is removed after invocation when the full contents are shown" {
    emptydir "$BATS_TEST_TMPDIR"
    TMPDIR="$BATS_TEST_TMPDIR" COLUMNS=30 run -0 headtail --lines 20 --separator-cutline-file < "${BATS_TEST_DIRNAME}/louds"
    assert_output - < "${BATS_TEST_DIRNAME}/louds"
    emptydir "$BATS_TEST_TMPDIR"
}

@test "list first and last line from files and input with file cutline containing count and filespec" {
    TMPDIR="$BATS_TEST_TMPDIR" COLUMNS=30 run -0 headtail --lines 1 --separator-cutline-file "${BATS_TEST_DIRNAME}/counts" - "${BATS_TEST_DIRNAME}/louds" < "${BATS_TEST_DIRNAME}/louds"
    assert_output -e - <<EOF
^==> ${BATS_TEST_DIRNAME}/counts <==
one
\[3 lines omitted from ${BATS_TEST_DIRNAME}/counts\]
five

==> ${BATS_TEST_TMPDIR}/headtail-.* <==
ONE
\[10 lines omitted from ${BATS_TEST_TMPDIR}/headtail-.*\]
TWELVE

==> ${BATS_TEST_DIRNAME}/louds <==
ONE
\[10 lines omitted from ${BATS_TEST_DIRNAME}/louds\]
TWELVE$
EOF
}
