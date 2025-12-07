#!/usr/bin/env bats

load fixture

@test "quiet search for single line regexp returns 0" {
    run -0 multilinegrep --quiet 'one-l..e' "$INPUT"
    assert_output ''
}

@test "quiet search for single line regexp with multiple matches returns 0" {
    run -0 multilinegrep --quiet '[Oo]ne' "$INPUT"
    assert_output ''
}

@test "quiet search for single line regexp with no matches returns 1" {
    run -1 multilinegrep --quiet 'doesN.tMatch' "$INPUT"
    assert_output ''
}

@test "quiet search for three-line regexp with multiple matches" {
    run -0 multilinegrep --quiet $'[Oo]ne.*\nt.*\n.*l' "$INPUT"
    assert_output ''
}

@test "quiet search for three-line regexp with no matches returns 1" {
    run -1 multilinegrep --quiet $'does\nN.t\nMatch' "$INPUT"
    assert_output ''
}
