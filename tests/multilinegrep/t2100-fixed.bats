#!/usr/bin/env bats

load fixture

@test "search for single line literal string as plain argument" {
    run -0 multilinegrep --fixed-strings 'one-line' "$INPUT"
    assert_output 'just one-line here'
    assert_output "$(grep --fixed-strings 'one-line' "$INPUT")"
}

@test "search for single line literal string as --regexp argument" {
    run -0 multilinegrep --fixed-strings --regexp 'one-line' "$INPUT"
    assert_output 'just one-line here'
    assert_output "$(grep --fixed-strings --regexp 'one-line' "$INPUT")"
}

@test "search for single line literal string with multiple matches" {
    run -0 multilinegrep --fixed-strings 'one' "$INPUT"
    assert_output - <<'EOF'
just one-line here
one-two
EOF
    assert_output "$(grep --fixed-strings 'one' "$INPUT")"
}

@test "search for single line literal string with no matches returns 1" {
    run -1 multilinegrep --fixed-strings 'doesNotMatch' "$INPUT"
    assert_output ''
    assert_output "$(grep --fixed-strings 'doesNotMatch' "$INPUT")"
}

@test "search for three-line literal string as plain argument" {
    run -0 multilinegrep --fixed-strings $'one-line here\ntwo/lines\nthree' "$INPUT"
    assert_output $'just one-line here\ntwo/lines\nthree l..es'
}

@test "search for three-line literal string as --regexp argument" {
    run -0 multilinegrep --fixed-strings --regexp $'one-line here\ntwo/lines\nthree' "$INPUT"
    assert_output $'just one-line here\ntwo/lines\nthree l..es'
}

@test "search for two-line literal string with multiple matches" {
    run -0 multilinegrep --fixed-strings $'here\ntwo' "$INPUT"
    assert_output - <<'EOF'
just one-line here
two/lines
Ones here
two
EOF
}

@test "search for three-line literal string with inner matches" {
    run -0 multilinegrep --fixed-strings $'one-line here\no/line\nthree' "$INPUT"
    assert_output $'just one-line here\ntwo/lines\nthree l..es'
}

@test "search for three-line literal string as block match" {
    run -0 multilinegrep --fixed-strings --regexp $'one-line here\ntwo/lines\nthree' "$INPUT"
    assert_output $'just one-line here\ntwo/lines\nthree l..es'
}

@test "search for three-line literal string that matches the entire line" {
    run -0 multilinegrep --fixed-strings $'just one-line here\ntwo/lines\nthree l..es' "$INPUT"
    assert_output $'just one-line here\ntwo/lines\nthree l..es'
}

@test "search for three-line literal string with no matches returns 1" {
    run -1 multilinegrep --fixed-strings $'does\nNot\nMatch' "$INPUT"
    assert_output ''
}

@test "search for three-line literal string with second line not matching returns 1" {
    run -1 multilinegrep --fixed-strings $'one-line here\nthree\nfour' "$INPUT"
    assert_output ''
}

@test "search for three-line literal string with last line not matching returns 1" {
    run -1 multilinegrep --fixed-strings $'one-line here\ntwo/lines\nfour' "$INPUT"
    assert_output ''
}
