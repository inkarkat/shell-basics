#!/usr/bin/env bats

load fixture

@test "prefix removal of empty input is empty and returns 99" {
    run -99 longestCommon --remove-prefix </dev/null
    assert_output ''
}

@test "prefix removal of single input line is empty" {
    run -0 longestCommon --remove-prefix <<<'foo bar'
    assert_output ''
}

@test "prefix removal of two identical input lines is empty" {
    run -0 longestCommon --remove-prefix <<'EOF'
foo bar
foo bar
EOF
    assert_output ''
}

@test "prefix removal of two input lines" {
    run -0 longestCommon --remove-prefix <<'EOF'
foo bar
foxy lady
EOF
    assert_output - <<'EOF'
o bar
xy lady
EOF
}

@test "prefix removal of three input lines" {
    run -0 longestCommon --remove-prefix <<'EOF'
fox
fo
foony
EOF
    assert_output - <<'EOF'
x

ony
EOF
}

@test "prefix removal of three completely different input lines is identical to input and returns 99" {
    run -99 longestCommon --remove-prefix <<'EOF'
loo
fox
foony
EOF
    assert_output $'loo\nfox\nfoony'
}
