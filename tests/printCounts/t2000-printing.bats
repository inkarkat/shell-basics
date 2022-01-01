#!/usr/bin/env bats

@test "print a single count of 1" {
    run printCounts 1 cat
    [ $status -eq 0 ]
    [ "$output" = "1 cat" ]
}

@test "print a single count of 2" {
    run printCounts 2 cat
    [ $status -eq 0 ]
    [ "$output" = "2 cats" ]
}

@test "print two counts of 2 and 1" {
    run printCounts 2 cat 1 dog
    [ $status -eq 0 ]
    [ "$output" = "2 cats and 1 dog" ]
}

@test "three counts of 2, 2, 2 use a different last joiner " {
    run printCounts 2 cat 2 dog 2 horse
    [ $status -eq 0 ]
    [ "$output" = "2 cats, 2 dogs and 2 horses" ]
}

@test "four counts of 2, 2, 2, 2 use a different last joiner " {
    run printCounts 2 cat 2 dog 2 horse 2 delfin
    [ $status -eq 0 ]
    [ "$output" = "2 cats, 2 dogs, 2 horses and 2 delfins" ]
}

@test "no output for a single count of 0" {
    run printCounts 0 cat
    [ $status -eq 0 ]
    [ "$output" = "" ]
}

@test "two counts of 0 and 1 omit the zero" {
    run printCounts 0 cat 1 dog
    [ $status -eq 0 ]
    [ "$output" = "1 dog" ]
}

@test "no output for two counts of 0 and 0" {
    run printCounts 0 cat 0 dog
    [ $status -eq 0 ]
    [ "$output" = "" ]
}
