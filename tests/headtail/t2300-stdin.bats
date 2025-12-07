#!/usr/bin/env bats

load fixture

@test "list 2 first and 2 last lines from standard input" {
    run -0 headtail --lines 2 < <(cat "${BATS_TEST_DIRNAME}/counts")
    assert_output - <<'EOF'
one
two
four
five
EOF
}

@test "list 2 first and 2 last lines from standard input with verbose" {
    run -0 headtail --verbose --lines 2 < <(cat "${BATS_TEST_DIRNAME}/counts")
    assert_output - <<'EOF'
==> standard input <==
one
two
four
five
EOF
}

@test "list 2 first and 2 last lines from standard input specified as -" {
    run -0 headtail --lines 2 - < <(cat "${BATS_TEST_DIRNAME}/counts")
    assert_output - <<'EOF'
one
two
four
five
EOF
}

@test "list 2 first and 2 last lines from two files and standard input in between as -" {
    run -0 headtail --verbose --lines 2 "${BATS_TEST_DIRNAME}/counts" - "${BATS_TEST_DIRNAME}/louds" < <(echo foo)
    assert_output - <<EOF
==> ${BATS_TEST_DIRNAME}/counts <==
one
two
four
five

==> standard input <==
foo

==> ${BATS_TEST_DIRNAME}/louds <==
ONE
TWO
ELEVEN
TWELVE
EOF
}

