#!/usr/bin/env bats

load fixture

@test "list 2 first and 2 last lines from file" {
    run -0 headtail --lines 2 "${BATS_TEST_DIRNAME}/counts"
    assert_output - <<'EOF'
one
two
four
five
EOF
}

@test "list 1 first and 1 last lines from file" {
    run -0 headtail --lines 1 "${BATS_TEST_DIRNAME}/counts"
    assert_output - <<'EOF'
one
five
EOF
}

@test "list 3 first and 3 last lines which is more than file has" {
    run -0 headtail --lines 3 "${BATS_TEST_DIRNAME}/counts"
    assert_output - < "${BATS_TEST_DIRNAME}/counts"
}

@test "list 7 first and 7 last lines which is more than twice what the file has" {
    run -0 headtail --lines 7 "${BATS_TEST_DIRNAME}/counts"
    assert_output - < "${BATS_TEST_DIRNAME}/counts"
}

@test "list 0 first and 0 last lines from file" {
    run -0 headtail --lines 0 "${BATS_TEST_DIRNAME}/counts"
    assert_output ''
}
