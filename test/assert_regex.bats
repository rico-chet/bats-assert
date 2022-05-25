#!/usr/bin/env bats

load test_helper

#
# Literal matching
#

# Correctness
@test "assert_regex() <value> <pattern>: succeeds if a <value> substring matches extended regular expression <pattern>" {
  run assert_regex 'abc' '^[a-z]b[c-z]+'
  assert_test_pass
}

@test "assert_regex() <value> <pattern>: fails if no <value> substring matches extended regular expression <pattern>" {
  run assert_regex 'bcd' '^[a-z]b[c-z]+'
  assert_test_fail <<'ERR_MSG'

-- value does not match regular expression --
value    : bcd
pattern  : ^[a-z]b[c-z]+
--
ERR_MSG
}
