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
