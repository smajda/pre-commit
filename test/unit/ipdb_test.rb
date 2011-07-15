require 'minitest_helper'
require 'pre-commit/checks/ipdb'

class IpdbTest < MiniTest::Unit::TestCase

  def test_should_detect_an_extraneous_ipdb_statement
    check = IpdbSetTrace.new
    check.staged_files = test_filename('ipdb.py')
    assert !check.run, 'We should prevent a `ipdb.set_trace()` from being committed'
  end

  def test_should_pass_a_file_with_no_extraneous_ipdb_statements
    check = IpdbSetTrace.new
    check.staged_files = test_filename('valid_file.py')
    assert check.run, 'A file with no `ipdb.set_trace()` statements should pass'
  end

  def test_error_message_should_contain_an_error_message_when_ipdb_is_found
    check = IpdbSetTrace.new
    check.staged_files = test_filename('ipdb.py')
    assert !check.run, 'We should prevent a `ipdb.set_trace()` from being committed'

    assert_match(/pre-commit: ipdb.set_trace found:/, check.error_message)
    assert_match(/ipdb.py/, check.error_message)
  end

end
