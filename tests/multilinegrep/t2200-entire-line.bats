#!/usr/bin/env bats

load fixture

@test "search for single entire line regexp as plain argument" {
    run -0 multilinegrep --line-regexp 'just one-l..e here' "$INPUT"
    assert_output 'just one-line here'
    assert_output "$(grep --line-regexp 'just one-l..e here' "$INPUT")"
}

@test "search for single entire line regexp as --regexp argument" {
    run -0 multilinegrep --line-regexp --regexp 'just one-l..e here' "$INPUT"
    assert_output 'just one-line here'
    assert_output "$(grep --line-regexp --regexp 'just one-l..e here' "$INPUT")"
}

@test "search for single entire line regexp with multiple matches" {
    run -0 multilinegrep --line-regexp '[Oo]ne.*[eo]' "$INPUT"
    assert_output - <<'EOF'
Ones here
one-two
EOF
    assert_output "$(grep --line-regexp '[Oo]ne.*[eo]' "$INPUT")"
}

@test "search for single entire line regexp with no matches returns 1" {
    run -1 multilinegrep --line-regexp 'one-l..e' "$INPUT"
    assert_output ''
    assert_output "$(grep --line-regexp 'one-l..e' "$INPUT")"
}

@test "search for two-line entire line regexp with branches" {
    run -0 multilinegrep --line-regexp $'two\|three\n.*l.*' "$INPUT"
    assert_output - <<'EOF'
two
else
two
else
three
the last
EOF
}

@test "search for three-line regexp with inner matches" {
    run -1 multilinegrep --line-regexp $'one-l..e here\no/l..e\nthre\+' "$INPUT"
    assert_output ''
}

@test "search for three-line regexp as block match" {
    run -1 multilinegrep --line-regexp --regexp $'one-l..e here\ntwo/l..es\nthre\+' "$INPUT"
    assert_output ''
}

@test "search for three-line regexp that matches the entire line" {
    run -0 multilinegrep --line-regexp $'just one-l..e here\ntwo/l..es\nthre\+ l\.\.es' "$INPUT"
    assert_output $'just one-line here\ntwo/lines\nthree l..es'
}

@test "search for entire three-line regexp as plain argument" {
    run -0 multilinegrep --line-regexp $'just one-l..e here\ntwo/l..es\nthre\+ l..es' "$INPUT"
    assert_output $'just one-line here\ntwo/lines\nthree l..es'
}

@test "search for entire three-line regexp as --regexp argument" {
    run -0 multilinegrep --line-regexp --regexp $'just one-l..e here\ntwo/l..es\nthre\+ l..es' "$INPUT"
    assert_output $'just one-line here\ntwo/lines\nthree l..es'
}

@test "search for entire three-line regexp with multiple matches" {
    run -0 multilinegrep --line-regexp $'[Oo]ne.*\nt.*\n.*l...\{0,1\}' "$INPUT"
    assert_output - <<'EOF'
Ones here
two
else
one-two
three
the last
EOF
}

@test "search for entire three-line regexp with no matches returns 1" {
    run -1 multilinegrep --line-regexp $'one-line.*\ntwo/lines\nthre\+' "$INPUT"
    assert_output ''
}

@test "search for entire three-line regexp with second line not matching returns 1" {
    run -1 multilinegrep --line-regexp $'just one-l..e.*\nthre\+.*\nfour' "$INPUT"
    assert_output ''
}

@test "search for entire three-line regexp with last line not matching returns 1" {
    run -1 multilinegrep --line-regexp $'just one-l..e.*\ntwo/l..e.*\nfour' "$INPUT"
    assert_output ''
}
