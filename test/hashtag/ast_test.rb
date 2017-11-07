require 'test_helper'

class AstTest < Minitest::Test
  include Hashtag::Ast

#   def test_pretty_print
#     tree = Program.new(expressions: [
#       Program.new(expressions: [
#         BinaryOperation.new(
#           left: Literal.new(value: 3),
#           operator: Literal.new(value: "+"),
#           left: Literal.new(value: 4),
#         )
#       ])
#     ])
#     representation =
# %Q{Program
#   expressions:
#     BinaryOperation
#       left:
#         Literal
#           value: 3
#       operator:
#         Literal
#           value: +
#       right:
#         Literal
#           value: 4
# }
#     assert_equal representation, Hashtag::Ast.pretty_print(tree)
#   end
end
