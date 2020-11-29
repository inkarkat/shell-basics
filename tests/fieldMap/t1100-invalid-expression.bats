#!/usr/bin/env bats

@test "invalid AWK expression prints AWK error message" {
    run fieldMap -F $'\t' 2 '++++' "${BATS_TEST_DIRNAME}/tabbed.txt"
    [ $status -eq 1 ]
    [ "${lines[0]%%:*}" = "awk" ]
    [ "${lines[1]##*^ }" = "syntax error" ]
}
