#!/usr/bin/env bats

load fixture

@test "path suffix of empty input is empty" {
    run -0 longestCommon --get-suffix --path-components </dev/null
    assert_output ''
}

@test "path suffix of single input line is that input line" {
    run -0 longestCommon --get-suffix --path-components <<<'foo bar'
    assert_output 'foo bar'
}

@test "path suffix of two identical input lines is the entire input line" {
    run -0 longestCommon --get-suffix --path-components <<'EOF'
foo bar
foo bar
EOF
    assert_output 'foo bar'
}

@test "absolute path component suffix of two input lines" {
    run -0 longestCommon --get-suffix --path-components <<'EOF'
/etc/kellog/foo/bar
/var/log/foo/bar
EOF
    assert_output 'foo/bar'
}

@test "absolute path component suffix of two identical input lines" {
    run -0 longestCommon --get-suffix --path-components <<'EOF'
/path/to/foo
/path/to/foo
EOF
    assert_output '/path/to/foo'
}

@test "absolute path component suffix of two almost identical input lines, just one leading slash missing from one" {
    run -0 longestCommon --get-suffix --path-components <<'EOF'
path/to/foo
/path/to/foo
EOF
    assert_output 'path/to/foo'
}

@test "mix of path separator and inner is ignored" {
    run -0 longestCommon --get-suffix --path-components <<'EOF'
/path/towards/foo/bar
/path/to/foo/bar
EOF
    assert_output 'foo/bar'
}

@test "remove path suffix of single input line is empty" {
    run -0 longestCommon --remove-suffix --path-components <<<'foo bar'
    assert_output ''
}

@test "remove absolute path component suffix of two input lines" {
    run -0 longestCommon --remove-suffix --path-components <<'EOF'
/etc/kellog/foo/bar
/var/log/foo/bar
EOF
    assert_output - <<'EOF'
/etc/kellog
/var/log
EOF
}
