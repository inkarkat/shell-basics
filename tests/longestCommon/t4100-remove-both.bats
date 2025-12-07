#!/usr/bin/env bats

load fixture

@test "both removal of empty input is empty and returns 99" {
    run -99 longestCommon --remove-both </dev/null
    assert_output ''
}

@test "both removal of single input line is empty" {
    run -0 longestCommon --remove-both <<<'foo bar'
    assert_output ''
}

@test "both removal of two identical input lines is empty" {
    run -0 longestCommon --remove-both <<'EOF'
foo bar
foo bar
EOF
    assert_output ''
}

@test "both removal of two input lines" {
    run -0 longestCommon --remove-both <<'EOF'
new signin
newer pin
EOF
    assert_output - <<'EOF'
 sign
er p
EOF
}

@test "both removal of three input lines" {
    run -0 longestCommon --remove-both <<'EOF'
stain
sin
signin
EOF
    assert_output - <<'EOF'
ta

ign
EOF
}

@test "both removal of three completely different input lines is identical to input and returns 99" {
    run -99 longestCommon --remove-both <<'EOF'
loo
fox
foony
EOF
    assert_output $'loo\nfox\nfoony'
}

@test "both removal of two identical prefixes and suffixes with different text in between" {
    run -0 longestCommon --remove-both <<'EOF'
foo-bar
fooXbar
EOF
    assert_output - <<'EOF'
-
X
EOF
}

@test "both removal of two identical prefixes and suffixes partially with different text in between" {
    run -0 longestCommon --remove-both <<'EOF'
foo-bar
foobar
EOF
    assert_output -- '-'
}

@test "both removal of two repeat-character prefixes and suffixes with one interrupted" {
    run -0 longestCommon --remove-both <<'EOF'
oooooo
ooooXoo
EOF
    assert_output - <<'EOF'

X
EOF
}

@test "both removal of three repeat-character prefixes and suffixes with two interrupted differently" {
    run -0 longestCommon --remove-both <<'EOF'
oooooo
ooooXoo
oXooooo
EOF
    assert_output - <<'EOF'
ooo
oooX
Xooo
EOF
}
