#!/usr/bin/env bats

load fixture

@test "prefix of empty input is empty" {
    run -0 longestCommon --get-prefix </dev/null
    assert_output ''
}

@test "prefix of single input line is that input line" {
    run -0 longestCommon --get-prefix <<<'foo bar'
    assert_output 'foo bar'
}

@test "prefix of two identical input lines is the entire input line" {
    run -0 longestCommon --get-prefix <<'EOF'
foo bar
foo bar
EOF
    assert_output 'foo bar'
}

@test "prefix of two input lines" {
    run -0 longestCommon --get-prefix <<'EOF'
foo bar
foxy lady
EOF
    assert_output 'fo'
}

@test "prefix of three input lines" {
    run -0 longestCommon --get-prefix <<'EOF'
fox
fo
foony
EOF
    assert_output 'fo'
}

@test "prefix of three completely different input lines is empty and returns 99" {
    run -99 longestCommon --get-prefix <<'EOF'
loo
fox
foony
EOF
    assert_output ''
}
