require 'test_helper'

class ParserTest < Minitest::Test
  include Hashtag::Ast

  def assert_parses_to(code, tree)
    result = Hashtag::Parser.new.parse(Hashtag::Lexer.new(code).tokens)
    # puts Hashtag::Ast.pretty_print result
    assert_equal tree, result
  end

  def test_parse_simple_term
    assert_parses_to "3\n",
      Program.new(expressions: [
        Literal.new(value: 3)
      ])
  end

  def test_parse_simple_addition
    assert_parses_to "3 + 4\n",
      Program.new(expressions: [
        BinaryOperation.new(
          left: Literal.new(value: 3),
          operator: :PLUS,
          right: Literal.new(value: 4)
        )
      ])
  end

  def test_parse_double_addition
    assert_parses_to "3 + 4 - 5\n",
      Program.new(expressions: [
        BinaryOperation.new(
          left: Literal.new(value: 3),
          operator: :PLUS,
          right: BinaryOperation.new(
            left: Literal.new(value: 4),
            operator: :MINUS,
            right: Literal.new(value: 5)
          )
        )
      ])
  end

  def test_operator_precedence
    assert_parses_to "3 * 4 + 5\n",
      Program.new(expressions: [
        BinaryOperation.new(
          left: BinaryOperation.new(
            left: Literal.new(value: 3),
            operator: :MULT,
            right: Literal.new(value: 4)
          ),
          operator: :PLUS,
          right: Literal.new(value: 5)
        )
      ])
  end

  def test_parenthentical_expressions
    assert_parses_to "3 * (4 + 5)\n",
      Program.new(expressions: [
        BinaryOperation.new(
          left: Literal.new(value: 3),
          operator: :MULT,
          right: BinaryOperation.new(
            left: Literal.new(value: 4),
            operator: :PLUS,
            right: Literal.new(value: 5)
          )
        )
      ])
  end

  def test_multiple_expresions
    assert_parses_to "3\n4\n5\n",
      Program.new(expressions: [
        Literal.new(value: 3),
        Literal.new(value: 4),
        Literal.new(value: 5)
      ])
  end

end
