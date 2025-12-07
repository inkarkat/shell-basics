#!/usr/bin/env bats

load fixture

@test "suffix removal of empty input is empty and returns 99" {
    run -99 longestCommon --remove-suffix </dev/null
    assert_output ''
}

@test "suffix removal of single input line is empty" {
    run -0 longestCommon --remove-suffix <<<'foo bar'
    assert_output ''
}

@test "suffix removal of two identical input lines is empty" {
    run -0 longestCommon --remove-suffix <<'EOF'
foo bar
foo bar
EOF
    assert_output ''
}

@test "suffix removal of two input lines" {
    run -0 longestCommon --remove-suffix <<'EOF'
new signin
old pin
EOF
    assert_output - <<'EOF'
new sign
old p
EOF
}

@test "suffix removal of three input lines" {
    run -0 longestCommon --remove-suffix <<'EOF'
pin
in
signin
EOF
    assert_output - <<'EOF'
p

sign
EOF
}

@test "suffix removal of three completely different input lines is identical to input and returns 99" {
    run -99 longestCommon --remove-suffix <<'EOF'
loo
fox
foony
EOF
    assert_output $'loo\nfox\nfoony'
}
