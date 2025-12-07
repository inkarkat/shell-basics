#!/usr/bin/env bats

load fixture

@test "search for single entire line literal string as plain argument" {
    run -0 multilinegrep --line-regexp --fixed-strings 'just one-line here' "$INPUT"
    assert_output 'just one-line here'
    assert_output "$(grep --line-regexp --fixed-strings 'just one-line here' "$INPUT")"
}

@test "search for single entire line literal string as --regexp argument" {
    run -0 multilinegrep --line-regexp --fixed-strings --regexp 'just one-line here' "$INPUT"
    assert_output 'just one-line here'
    assert_output "$(grep --line-regexp --fixed-strings --regexp 'just one-line here' "$INPUT")"
}

@test "search for single entire line literal string with multiple matches" {
    run -0 multilinegrep --line-regexp --fixed-strings 'three' "$INPUT"
    assert_output - <<'EOF'
three
three
EOF
    assert_output "$(grep --line-regexp --fixed-strings 'three' "$INPUT")"
}

@test "search for single entire line literal string with no matches returns 1" {
    run -1 multilinegrep --line-regexp --fixed-strings 'doesNotMatch' "$INPUT"
    assert_output ''
    assert_output "$(grep --line-regexp --fixed-strings 'doesNotMatch' "$INPUT")"
}

@test "search for entire three-line literal string as plain argument" {
    run -0 multilinegrep --line-regexp --fixed-strings $'just one-line here\ntwo/lines\nthree l..es' "$INPUT"
    assert_output $'just one-line here\ntwo/lines\nthree l..es'
}

@test "search for entire three-line literal string as --regexp argument" {
    run -0 multilinegrep --line-regexp --fixed-strings --regexp $'just one-line here\ntwo/lines\nthree l..es' "$INPUT"
    assert_output $'just one-line here\ntwo/lines\nthree l..es'
}

@test "search for two-line literal string with multiple matches" {
    run -0 multilinegrep --line-regexp --fixed-strings $'two\nelse' "$INPUT"
    assert_output - <<'EOF'
two
else
two
else
EOF
}

@test "search for three-line literal string with inner matches" {
    run -1 multilinegrep --line-regexp --fixed-strings $'one-line here\no/line\nthree' "$INPUT"
    assert_output ''
}

@test "search for three-line literal string as block match" {
    run -1 multilinegrep --line-regexp --fixed-strings --regexp $'one-line here\ntwo/lines\nthree' "$INPUT"
    assert_output ''
}

@test "search for three-line literal string that matches the entire line" {
    run -0 multilinegrep --line-regexp --fixed-strings $'just one-line here\ntwo/lines\nthree l..es' "$INPUT"
    assert_output $'just one-line here\ntwo/lines\nthree l..es'
}

@test "search for entire three-line literal string with no matches returns 1" {
    run -1 multilinegrep --line-regexp --fixed-strings $'does\nNot\nMatch' "$INPUT"
    assert_output ''
}

@test "search for entire three-line literal string with second line not matching returns 1" {
    run -1 multilinegrep --line-regexp --fixed-strings $'just one-line here\nthree\nfour' "$INPUT"
    assert_output ''
}

@test "search for entire three-line literal string with last line not matching returns 1" {
    run -1 multilinegrep --line-regexp --fixed-strings $'just one-line here\ntwo/lines\nfour' "$INPUT"
    assert_output ''
}
