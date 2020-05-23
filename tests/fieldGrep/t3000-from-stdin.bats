#!/usr/bin/env bats

stdinFieldGrep()
{
    cat -- "${BATS_TEST_DIRNAME}/tabbed.txt" | fieldGrep "$@"
}

@test "grep the first field with fixed text from stdin yields one line" {
    run stdinFieldGrep -F $'\t' --fixed-strings --regexp oo 1
    [ $status -eq 0 ]
    [ "$output" = "foo	first	100	A Here" ]
}
