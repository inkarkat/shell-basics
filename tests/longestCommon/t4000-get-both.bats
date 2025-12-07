#!/usr/bin/env bats

load fixture

@test "both of empty input is empty" {
    run -0 longestCommon --get-both </dev/null
    assert_output ''
}

@test "both of single input line is that input line, as prefix only" {
    run -0 longestCommon --get-both <<<'foo bar'
    assert_output 'foo bar'
}

@test "both of two identical input lines is the entire input line, as prefix only" {
    run -0 longestCommon --get-both <<'EOF'
foo bar
foo bar
EOF
    assert_output 'foo bar'
}

@test "both of two input lines" {
    run -0 longestCommon --get-both <<'EOF'
new signin
newer pin
EOF
    assert_output - <<'EOF'
new
in
EOF
}

@test "both of three input lines" {
    run -0 longestCommon --get-both <<'EOF'
stain
sin
signin
EOF
    assert_output - <<'EOF'
s
in
EOF
}

@test "both of three completely different input lines is empty and returns 99" {
    run -99 longestCommon --get-both <<'EOF'
loo
fox
foony
EOF
    assert_output ''
}

@test "both of two identical prefixes and suffixes with different text in between" {
    run -0 longestCommon --get-both <<'EOF'
foo-bar
fooXbar
EOF
    assert_output - <<'EOF'
foo
bar
EOF
}

@test "both of two identical prefixes and suffixes partially with different text in between" {
    run -0 longestCommon --get-both <<'EOF'
foo-bar
foobar
EOF
    assert_output - <<'EOF'
foo
bar
EOF
}

@test "both of two repeat-character prefixes and suffixes with one interrupted" {
    run -0 longestCommon --get-both <<'EOF'
oooooo
ooooXoo
EOF
    assert_output - <<'EOF'
oooo
oo
EOF
}

@test "both of three repeat-character prefixes and suffixes with two interrupted differently" {
    run -0 longestCommon --get-both <<'EOF'
oooooo
ooooXoo
oXooooo
EOF
    assert_output - <<'EOF'
o
oo
EOF
}
