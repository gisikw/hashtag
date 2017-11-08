require 'test_helper'

class InterpreterTest < Minitest::Test

  def assert_evaluates_to(code, result)
    assert_equal result,
      Hashtag::Interpreter.new.eval(Hashtag::Parser.new.parse(Hashtag::Lexer.new(code).tokens))
  end

  def test_basic_identity
    assert_evaluates_to "3\n", 3
  end

  def test_various_expresions
    assert_evaluates_to "3 + 4\n", 7
    assert_evaluates_to "3 * 4\n", 12
    assert_evaluates_to "3 * 4 + 5\n", 17
    assert_evaluates_to "3 * (4 + 5)\n", 27
  end

end
