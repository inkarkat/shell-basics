#!/usr/bin/env bats

load fixture

@test "print a single count of 1" {
    run -0 printCounts 1 cat
    assert_output '1 cat'
}

@test "print a single count of 2" {
    run -0 printCounts 2 cat
    assert_output '2 cats'
}

@test "print two counts of 2 and 1" {
    run -0 printCounts 2 cat 1 dog
    assert_output '2 cats and 1 dog'
}

@test "three counts of 2, 2, 2 use a different last joiner " {
    run -0 printCounts 2 cat 2 dog 2 horse
    assert_output '2 cats, 2 dogs and 2 horses'
}

@test "four counts of 2, 2, 2, 2 use a different last joiner " {
    run -0 printCounts 2 cat 2 dog 2 horse 2 delfin
    assert_output '2 cats, 2 dogs, 2 horses and 2 delfins'
}

@test "no output for a single count of 0" {
    run -0 printCounts 0 cat
    assert_output ''
}

@test "two counts of 0 and 1 omit the zero" {
    run -0 printCounts 0 cat 1 dog
    assert_output '1 dog'
}

@test "no output for two counts of 0 and 0" {
    run -0 printCounts 0 cat 0 dog
    assert_output ''
}
