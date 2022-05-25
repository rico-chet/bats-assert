# `assert_regex`
#
# This function is similar to `assert_equal` but uses pattern matching instead
# of equality, by wrapping `[[ value =~ pattern ]]`.
#
# Fail if the value (first parameter) does not match the pattern (second
# parameter).
#
# ```bash
# @test 'assert_regex()' {
#   assert_regex 'what' 'x$'
# }
# ```
#
# On failure, the value and the pattern are displayed.
#
# ```
# -- values does not match regular expression --
# value    : what
# pattern  : x$
# --
# ```
#
# If the value is longer than one line then it is displayed in *multi-line*
# format.
#
# Multi-line value matches a single-line pattern when one of its lines matches,
# e.g. following asserts succeed:
#
# ```bash
# assert_regex $'one\ntwo' '^one'
# assert_regex $'one\ntwo' 'one'
# assert_regex $'one\ntwo' 'two'
# assert_regex $'one\ntwo' 'two$'
# ```
#
# A newline in a value does *not* match `^` or `$` in the pattern, e.g.
# following asserts fail:
#
# ```bash
# assert_regex $'one\ntwo' 'one$'
# assert_regex $'one\ntwo' '^two'
# assert_regex $'one\ntwo\n' 'two$'
# ```
#
# Multi-line value's line breaks match patterns' line breaks, e.g. following
# asserts succeed:
#
# ```bash
# assert_regex $'one\ntwo' $'e\nt'
# assert_regex $'one\ntwo' $'\nt'
# assert_regex $'one\ntwo\n' $'o\n'
# ```
#
# An error is displayed if the specified extended regular expression is
# invalid.
assert_regex() {
	local -r value="${1}"
	local -r pattern="${2}"

	if [[ '' =~ ${pattern} ]] || (( ${?} == 2 )); then
		echo "Invalid extended regular expression: \`${pattern}'" \
		| batslib_decorate 'ERROR: assert_regex' \
		| fail
	elif ! [[ "${value}" =~ ${pattern} ]]; then
		batslib_print_kv_single_or_multi 8 \
			'value' "${value}" \
			'pattern'  "${pattern}" \
		| batslib_decorate 'value does not match regular expression' \
		| fail
	fi
}
