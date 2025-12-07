#!/usr/bin/env bats

load fixture

@test "search for single line block regexp as plain argument" {
    run -0 multilinegrep --block-regexp 'one-l..e' "$INPUT"
    assert_output 'just one-line here'
}

@test "search for single line block regexp as --regexp argument" {
    run -0 multilinegrep --block-regexp --regexp 'one-l..e' "$INPUT"
    assert_output 'just one-line here'
}

@test "search for single line block regexp with multiple matches" {
    run -0 multilinegrep --block-regexp '[Oo]ne' "$INPUT"
    assert_output - <<'EOF'
just one-line here
Ones here
one-two
EOF
}

@test "search for single line block regexp with no matches returns 1" {
    run -1 multilinegrep --block-regexp 'doesN.tMatch' "$INPUT"
    assert_output ''
}

@test "search for single line block regexp that matches the entire line" {
    run -0 multilinegrep --block-regexp 'just one-l..e here' "$INPUT"
    assert_output 'just one-line here'
}

@test "search for two-line block regexp with branches" {
    run -0 multilinegrep --block-regexp $'two\|three\n.*l' "$INPUT"
    assert_output - <<'EOF'
two
else
two
else
three
the last
EOF
}

@test "search for three-line block regexp with inner matches" {
    run -1 multilinegrep --block-regexp $'one-l..e here\no/l..e\nthre\+' "$INPUT"
    assert_output ''
}

@test "search for three-line block regexp as block match" {
    run -0 multilinegrep --block-regexp --regexp $'one-l..e here\ntwo/l..es\nthre\+' "$INPUT"
    assert_output $'just one-line here\ntwo/lines\nthree l..es'
}

@test "search for three-line block regexp that matches the entire line" {
    run -0 multilinegrep --block-regexp $'just one-l..e here\ntwo/l..es\nthre\+ l\.\.es' "$INPUT"
    assert_output $'just one-line here\ntwo/lines\nthree l..es'
}

@test "search for three-line block regexp with multiple matches" {
    run -0 multilinegrep --block-regexp $'[Oo]ne.*\nt.*\n.*l' "$INPUT"
    assert_output - <<'EOF'
just one-line here
two/lines
three l..es
Ones here
two
else
one-two
three
the last
EOF
}

@test "search for three-line block regexp with no matches returns 1" {
    run -1 multilinegrep --block-regexp $'does\nN.t\nMatch' "$INPUT"
    assert_output ''
}

@test "search for three-line block regexp with second line not matching returns 1" {
    run -1 multilinegrep --block-regexp $'one-l..e.*\nthre\+.*\nfour' "$INPUT"
    assert_output ''
}

@test "search for three-line block regexp with last line not matching returns 1" {
    run -1 multilinegrep --block-regexp $'one-l..e.*\ntwo/l..e.*\nfour' "$INPUT"
    assert_output ''
}
