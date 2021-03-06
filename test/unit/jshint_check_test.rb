require 'minitest/autorun'
require 'pre-commit/checks/jshint_check'

class JshintCheckTest < MiniTest::Unit::TestCase

  def test_should_know_where_the_jshint_source_code_is
    check = PreCommit::JshintCheck.new
    expected = File.join(PreCommit.root, 'lib/support/jshint/jshint.js')
    assert_equal(expected, check.linter_src)
  end

  def test_should_display_errors
    check = PreCommit::JshintCheck.new
    error_object = {
      'reason' => 'forgot semi-colon',
      'evidence' => 'var foo = bar',
      'line' => '14'
    }

    expected = "pre-commit: JSHINT forgot semi-colon\nfoo.js:15 var foo = bar"
    assert_equal(expected, check.display_error(error_object, 'foo.js'))
  end

end
