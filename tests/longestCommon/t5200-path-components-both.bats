#!/usr/bin/env bats

load fixture

@test "path both of empty input is empty" {
    run -0 longestCommon --get-both --path-components </dev/null
    assert_output ''
}

@test "path both of single input line is that input line, as prefix only" {
    run -0 longestCommon --get-both --path-components <<<'foo bar'
    assert_output 'foo bar'
}

@test "path both of two identical input lines is the entire input line, as prefix only" {
    run -0 longestCommon --get-both --path-components <<'EOF'
foo bar
foo bar
EOF
    assert_output 'foo bar'
}

@test "absolute path component both of two input lines" {
    run -0 longestCommon --get-both --path-components <<'EOF'
/opt/etc/kellog/foo/bar
/opt/var/log/foo/bar
EOF
    assert_output - <<'EOF'
/opt
foo/bar
EOF
}

@test "absolute path component both of two identical input lines" {
    run -0 longestCommon --get-both --path-components <<'EOF'
/path/to/foo
/path/to/foo
EOF
    assert_output '/path/to/foo'
}

@test "remove path both of single input line is empty" {
    run -0 longestCommon --remove-both --path-components <<<'foo bar'
    assert_output ''
}

@test "remove absolute path component both of two input lines" {
    run -0 longestCommon --remove-both --path-components <<'EOF'
/opt/etc/kellog/foo/bar
/opt/var/log/foo/bar
EOF
    assert_output - <<'EOF'
etc/kellog
var/log
EOF
}
