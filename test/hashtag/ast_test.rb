require 'test_helper'

class AstTest < Minitest::Test
  include Hashtag::Ast

  def test_pretty_print
    tree = Hashtag::Parser.new.parse(Hashtag::Lexer.new("3 + 4\n").tokens)
    representation =
%Q{Program
  expressions:
    BinaryOperation
      left:
        Literal
          value: 3
      operator: PLUS
      right:
        Literal
          value: 4
}
    assert_equal representation, Hashtag::Ast.pretty_print(tree)
  end
end
