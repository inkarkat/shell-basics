#!/usr/bin/env bats

load fixture

@test "a bad sort option exits with error" {
    LANG=C run -1 mergeLists --sort=thisIsNotAValidSortOption foo bar baz
    assert_line -n 0 "sort: invalid argument 'thisIsNotAValidSortOption' for '--sort'"
}
