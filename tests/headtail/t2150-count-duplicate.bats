#!/usr/bin/env bats

load fixture

@test "list 2 first and 2 last lines from file, no duplication necessary" {
    run -0 headtail --lines 2 --duplicate-if-short "${BATS_TEST_DIRNAME}/counts"
    assert_output - <<'EOF'
one
two
four
five
EOF
}

@test "list 3 first and 3 last lines with duplication" {
    run -0 headtail --lines 3 --duplicate-if-short "${BATS_TEST_DIRNAME}/counts"
    assert_output - <<'EOF'
one
two
three
three
four
five
EOF
}

@test "list 5 first and 5 last lines with duplication" {
    run -0 headtail --lines 5 --duplicate-if-short "${BATS_TEST_DIRNAME}/counts"
    assert_output - <<'EOF'
one
two
three
four
five
one
two
three
four
five
EOF
}

@test "list 7 first and 7 last lines with duplication and truncation to 5" {
    run -0 headtail --lines 7 --duplicate-if-short "${BATS_TEST_DIRNAME}/counts"
    assert_output - <<'EOF'
one
two
three
four
five
one
two
three
four
five
EOF
}
