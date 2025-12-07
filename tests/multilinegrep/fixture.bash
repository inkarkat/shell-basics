#!/bin/bash

bats_require_minimum_version 1.5.0
bats_load_library bats-support
bats_load_library bats-assert

export INPUT="${BATS_TEST_DIRNAME}/input"
export INPUT2="${BATS_TEST_DIRNAME}/input2"
