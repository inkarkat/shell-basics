#!/usr/bin/env bats

load fixture

@test "print two counts of 2 and 1 with custom prefix" {
    run -0 printCounts --prefix 'I see ' 2 cat 1 dog
    assert_output 'I see 2 cats and 1 dog'
}

@test "print two counts of 2 and 1 with custom suffix" {
    run -0 printCounts --suffix ' were spotted' 2 cat 1 dog
    assert_output '2 cats and 1 dog were spotted'
}

@test "print two counts of 2 and 1 with custom prefix and suffix" {
    run -0 printCounts --prefix 'I see ' --suffix ' everywhere I go' 2 cat 1 dog
    assert_output 'I see 2 cats and 1 dog everywhere I go'
}

@test "prefix and suffix combined with custom empty output for a single count of 0" {
    run -0 printCounts --prefix 'I see ' --suffix ' everywhere I go' --empty 'no felines' 0 cat
    assert_output 'I see no felines everywhere I go'
}
