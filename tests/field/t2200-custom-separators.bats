#!/usr/bin/env bats

@test "print the first two fields with custom separator" {
    run field --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' 1 - 2
    [ $status -eq 0 ]
    [ "$output" = "foo-first
bar-second
baz-third" ]
}

@test "print the first, second and last fields with custom separators" {
    run field --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' 1 @ 2 - -1
    [ $status -eq 0 ]
    [ "$output" = "foo@first-A Here
bar@second-B There
baz@third-C U" ]
}

@test "print all fields in reverse order with custom and original separators" {
    run field --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' 4 3 - 2 1
    [ $status -eq 0 ]
    [ "$output" = "A Here	100-first	foo
B There	201-second	bar
C U	333-third	baz" ]
}

@test "print all fields in reverse order with custom separators containing and consisting of whitespace" {
    run field --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' 4 '  ' 3 ' - ' 2 $'\t' 1
    [ $status -eq 0 ]
    [ "$output" = "A Here  100 - first	foo
B There  201 - second	bar
C U  333 - third	baz" ]
}

@test "print all fields in reverse order with special custom separators" {
    run field --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' 4 \" 3 \\ 2 $'\n' 1
    [ $status -eq 0 ]
    [ "$output" = 'A Here"100\first
foo
B There"201\second
bar
C U"333\third
baz' ]
}

@test "print all fields in reverse order with empty separators" {
    run field --input "${BATS_TEST_DIRNAME}/tabbed.txt" -F $'\t' 4 '' 3 '' 2 '' 1
    [ $status -eq 0 ]
    [ "$output" = "A Here100firstfoo
B There201secondbar
C U333thirdbaz" ]
}
