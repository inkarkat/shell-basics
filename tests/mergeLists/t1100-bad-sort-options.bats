#!/usr/bin/env bats

@test "a bad sort option exits with error" {
    LANG=C run mergeLists --sort=thisIsNotAValidSortOption foo bar baz
    [ $status -eq 1 ]
    [ "${lines[0]}" = "sort: invalid argument 'thisIsNotAValidSortOption' for '--sort'" ]
}
