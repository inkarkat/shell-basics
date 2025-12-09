#!/usr/bin/env bats

load fixture

@test "list all but 2 first and 2 last lines from standard input" {
    run -0 headtail --lines -2 < "${BATS_TEST_DIRNAME}/counts"
    assert_output 'three'
}

@test "list all but 2 first and 2 last lines from standard input with verbose" {
    run -0 headtail --verbose --lines -2 < "${BATS_TEST_DIRNAME}/counts"
    assert_output - <<'EOF'
==> standard input <==
three
EOF
}

@test "list all but 2 first and 2 last lines from standard input specified as -" {
    run -0 headtail --lines -2 - < "${BATS_TEST_DIRNAME}/counts"
    assert_output 'three'
}
