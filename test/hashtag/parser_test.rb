require 'test_helper'

class ParserTest < Minitest::Test
  include Hashtag::Ast

  def parse(src)
    Hashtag::Parser.new.parse(Hashtag::Lexer.new(src).tokens)
  end

  def test_parse_simple_add
    code = parse("3 + 4\n")
    tree = Program.new(expressions: [
      OperatorExpression.new(
        operator: Operator.new(op: :+),
        left: Number.new(value: 3),
        right: Number.new(value: 4)
      )
    ])
    assert_equal tree, code
  end

end
