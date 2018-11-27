setup() {
  export TEST_MAIN_DIR="${BATS_TEST_DIRNAME}/.."
  export TEST_DEPS_DIR="${TEST_DEPS_DIR-${TEST_MAIN_DIR}/..}"

  # Load dependencies.
  load "${TEST_DEPS_DIR}/bats-support/load.bash"

  # Load library.
  load '../load'

  assert_test_pass() {
    test "$status" -eq 0
    test "${#lines[@]}" -eq 0
  }

  assert_test_fail() {
    local err_msg="${1-$(cat -)}"
    local num_lines="$(printf '%s' "$err_msg" | wc -l)"


    test "$status" -eq 1
    test "${#lines[@]}" -eq "$num_lines"
    test "$output" == "$err_msg"
  }
}
