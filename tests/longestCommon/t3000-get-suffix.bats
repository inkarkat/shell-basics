#!/usr/bin/env bats

load fixture

@test "suffix of empty input is empty" {
    run -0 longestCommon --get-suffix </dev/null
    assert_output ''
}

@test "suffix of single input line is that input line" {
    run -0 longestCommon --get-suffix <<<'foo bar'
    assert_output 'foo bar'
}

@test "suffix of two identical input lines is the entire input line" {
    run -0 longestCommon --get-suffix <<'EOF'
foo bar
foo bar
EOF
    assert_output 'foo bar'
}

@test "suffix of two input lines" {
    run -0 longestCommon --get-suffix <<'EOF'
new signin
old pin
EOF
    assert_output 'in'
}

@test "suffix of three input lines" {
    run -0 longestCommon --get-suffix <<'EOF'
pin
in
signin
EOF
    assert_output 'in'
}

@test "suffix of three completely different input lines is empty and returns 99" {
    run -99 longestCommon --get-suffix <<'EOF'
loo
fox
foony
EOF
    assert_output ''
}
