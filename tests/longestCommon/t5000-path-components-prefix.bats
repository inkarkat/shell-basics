#!/usr/bin/env bats

load fixture

@test "path prefix of empty input is empty" {
    run -0 longestCommon --get-prefix --path-components </dev/null
    assert_output ''
}

@test "path prefix of single input line is that input line" {
    run -0 longestCommon --get-prefix --path-components <<<'foo bar'
    assert_output 'foo bar'
}

@test "path prefix of two identical input lines is the entire input line" {
    run -0 longestCommon --get-prefix --path-components <<'EOF'
foo bar
foo bar
EOF
    assert_output 'foo bar'
}

@test "absolute path component prefix of two input lines" {
    run -0 longestCommon --get-prefix --path-components <<'EOF'
/path/to/foo
/path/to/forbidden/bar
EOF
    assert_output '/path/to'
}

@test "absolute path component prefix of two identical input lines" {
    run -0 longestCommon --get-prefix --path-components <<'EOF'
/path/to/foo
/path/to/foo
EOF
    assert_output '/path/to/foo'
}

@test "absolute path component prefix of two almost identical input lines, just one final slash missing from one" {
    run -0 longestCommon --get-prefix --path-components <<'EOF'
/path/to/foo
/path/to/foo/
EOF
    assert_output '/path/to/foo'
}

@test "relative path component prefix of two input lines" {
    run -0 longestCommon --get-prefix --path-components <<'EOF'
./path/to/foo
./path/to/forbidden/bar
EOF
    assert_output './path/to'
}

@test "mix of path separator and inner is ignored" {
    run -0 longestCommon --get-prefix --path-components <<'EOF'
/path/towards/foo/bar
/path/to/foo/bar
EOF
    assert_output '/path'
}

@test "remove path prefix of single input line is empty" {
    run -0 longestCommon --remove-prefix --path-components <<<'foo bar'
    assert_output ''
}

@test "remove absolute path component prefix of two input lines" {
    run -0 longestCommon --remove-prefix --path-components <<'EOF'
/path/to/foo
/path/to/forbidden/bar
EOF
    assert_output - <<'EOF'
foo
forbidden/bar
EOF
}
