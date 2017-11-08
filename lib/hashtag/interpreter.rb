module Hashtag
  class Interpreter
    include Hashtag::Ast

    def eval(node)
      case node
      when Program
        node.expressions.map { |expr| eval(expr) }.last
      when BinaryOperation
        left = eval(node.left)
        right = eval(node.right)
        case node.operator
        when :PLUS
          left + right
        when :MINUS
          left - right
        when :MULT
          left * right
        when :DIV
          left / right
        end
      when Literal
        node.value
      end
    end

  end
end
