#!/usr/bin/env bats

load fixture

@test "search for single line regexp as plain argument" {
    run -0 multilinegrep 'one-l..e' "$INPUT"
    assert_output 'just one-line here'
    [ "$(grep 'one-l..e' "$INPUT")" = "$output" ]
}
@test "search for single line regexp as plain argument and file separated with --" {
    run -0 multilinegrep 'one-l..e' -- "$INPUT"
    assert_output 'just one-line here'
    [ "$(grep 'one-l..e' "$INPUT")" = "$output" ]
}

@test "search for single line regexp as --regexp argument" {
    run -0 multilinegrep --regexp 'one-l..e' "$INPUT"
    assert_output 'just one-line here'
    [ "$(grep --regexp 'one-l..e' "$INPUT")" = "$output" ]
}

@test "search for single line regexp as --regexp argument and file separated with --" {
    run -0 multilinegrep --regexp 'one-l..e' -- "$INPUT"
    assert_output 'just one-line here'
    [ "$(grep --regexp 'one-l..e' "$INPUT")" = "$output" ]
}

@test "search for single line regexp with multiple matches" {
    run -0 multilinegrep '[Oo]ne' "$INPUT"
    assert_output - <<'EOF'
just one-line here
Ones here
one-two
EOF
    [ "$(grep '[Oo]ne' "$INPUT")" = "$output" ]
}

@test "search for single line regexp with no matches returns 1" {
    run -1 multilinegrep 'doesN.tMatch' "$INPUT"
    assert_output ''
    [ "$(grep 'doesN.tMatch' "$INPUT")" = "$output" ]
}

@test "search for single line regexp that matches the entire line" {
    run -0 multilinegrep 'just one-l..e here' "$INPUT"
    assert_output 'just one-line here'
    [ "$(grep 'just one-l..e here' "$INPUT")" = "$output" ]
}

@test "search for two-line regexp with branches" {
    run -0 multilinegrep $'two\|three\n.*l' "$INPUT"
    assert_output - <<'EOF'
two/lines
three l..es
two
else
two
else
three
the last
EOF
}

@test "search for three-line regexp with inner matches" {
    run -0 multilinegrep $'one-l..e here\no/l..e\nthre\+' "$INPUT"
    assert_output $'just one-line here\ntwo/lines\nthree l..es'
}

@test "search for three-line regexp as block match" {
    run -0 multilinegrep --regexp $'one-l..e here\ntwo/l..es\nthre\+' "$INPUT"
    assert_output $'just one-line here\ntwo/lines\nthree l..es'
}

@test "search for three-line regexp that matches the entire line" {
    run -0 multilinegrep $'just one-l..e here\ntwo/l..es\nthre\+ l\.\.es' "$INPUT"
    assert_output $'just one-line here\ntwo/lines\nthree l..es'
}

@test "search for three-line regexp with multiple matches" {
    run -0 multilinegrep $'[Oo]ne.*\nt.*\n.*l' "$INPUT"
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

@test "search for three-line regexp with no matches returns 1" {
    run -1 multilinegrep $'does\nN.t\nMatch' "$INPUT"
    assert_output ''
}

@test "search for three-line regexp with second line not matching returns 1" {
    run -1 multilinegrep $'one-l..e.*\nthre\+.*\nfour' "$INPUT"
    assert_output ''
}

@test "search for three-line regexp with last line not matching returns 1" {
    run -1 multilinegrep $'one-l..e.*\ntwo/l..e.*\nfour' "$INPUT"
    assert_output ''
}
