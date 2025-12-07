#!/usr/bin/env bats

load fixture

@test "search for single line extended regexp as plain argument" {
    run -0 multilinegrep --extended-regexp 'one-l..e' "$INPUT"
    assert_output 'just one-line here'
    assert_output "$(grep --extended-regexp 'one-l..e' "$INPUT")"
}

@test "search for single line extended regexp as --regexp argument" {
    run -0 multilinegrep --extended-regexp --regexp 'one-l..e' "$INPUT"
    assert_output 'just one-line here'
    assert_output "$(grep --extended-regexp --regexp 'one-l..e' "$INPUT")"
}

@test "search for single line extended regexp with multiple matches" {
    run -0 multilinegrep --extended-regexp '[Oo]ne' "$INPUT"
    assert_output - <<'EOF'
just one-line here
Ones here
one-two
EOF
    assert_output "$(grep --extended-regexp '[Oo]ne' "$INPUT")"
}

@test "search for single line extended regexp with no matches returns 1" {
    run -1 multilinegrep --extended-regexp 'doesN.tMatch' "$INPUT"
    assert_output ''
    assert_output "$(grep --extended-regexp 'doesN.tMatch' "$INPUT")"
}

@test "search for two-line extended regexp with branches" {
    run -0 multilinegrep --extended-regexp $'two|three\n.*l' "$INPUT"
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

@test "search for three-line extended regexp with inner matches" {
    run -0 multilinegrep --extended-regexp $'one-l..e here\no/l..e\nthre+' "$INPUT"
    assert_output $'just one-line here\ntwo/lines\nthree l..es'
}

@test "search for three-line extended regexp as block match" {
    run -0 multilinegrep --extended-regexp --regexp $'one-l..e here\ntwo/l..es\nthre+' "$INPUT"
    assert_output $'just one-line here\ntwo/lines\nthree l..es'
}

@test "search for three-line extended regexp that matches the entire line" {
    run -0 multilinegrep --extended-regexp $'just one-l..e here\ntwo/l..es\nthre+ l\.\.es' "$INPUT"
    assert_output $'just one-line here\ntwo/lines\nthree l..es'
}

@test "search for three-line extended regexp as plain argument" {
    run -0 multilinegrep --extended-regexp $'one-l..e here\ntwo/l..es\nthre+' "$INPUT"
    assert_output $'just one-line here\ntwo/lines\nthree l..es'
}

@test "search for three-line extended regexp as --regexp argument" {
    run -0 multilinegrep --extended-regexp --regexp $'one-l..e here\ntwo/l..es\nthre+' "$INPUT"
    assert_output $'just one-line here\ntwo/lines\nthree l..es'
}

@test "search for three-line extended regexp with multiple matches" {
    run -0 multilinegrep --extended-regexp $'[Oo]ne.*\nt.*\n.*l' "$INPUT"
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

@test "search for three-line extended regexp with no matches returns 1" {
    run -1 multilinegrep --extended-regexp $'does\nN.t\nMatch' "$INPUT"
    assert_output ''
}

@test "search for three-line extended regexp with second line not matching returns 1" {
    run -1 multilinegrep --extended-regexp $'one-l..e.*\nthre+.*\nfour' "$INPUT"
    assert_output ''
}

@test "search for three-line extended regexp with last line not matching returns 1" {
    run -1 multilinegrep --extended-regexp $'one-l..e.*\ntwo/l..e.*\nfour' "$INPUT"
    assert_output ''
}
