require 'test_helper'

class AstTest < Minitest::Test
  include Hashtag::Ast

  def test_pretty_print
    tree = Program.new(expressions: [
      OperatorExpression.new(
        operator: Operator.new(op: :+),
        left: Number.new(value: 3),
        right: Number.new(value: 4)
      ),
      OperatorExpression.new(
        operator: Operator.new(op: :+),
        left: Number.new(value: 6),
        right: Number.new(value: 11)
      )
    ])
    representation =
%Q{Program
  expressions:
    OperatorExpression
      left:
        Number
          value: 3
      operator:
        Operator
          op: +
      right:
        Number
          value: 4
    OperatorExpression
      left:
        Number
          value: 6
      operator:
        Operator
          op: +
      right:
        Number
          value: 11
}
    assert_equal representation, Hashtag::Ast.pretty_print(tree)
  end
end
