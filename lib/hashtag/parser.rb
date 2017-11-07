module Hashtag
  class Parser
    include Ast

    # <Program> ::= <Expression>+
    # <Expression> ::= <OperatorExpression> "NEWLINE"
    # <OperatorExpression> ::= <Term> <Operator> <Term>
    # <Term> ::= <Number>
    # <Operator> ::= "+"

    def parse(tokens)
      @tokens = tokens
      @current = 0
      parse_program
    end

    def parse_program
      expressions = []
      while @current < @tokens.length && expression = parse_expression
        expressions << expression
      end
      Program.new(expressions: expressions)
    end

    def parse_expression
      val = parse_operator_expression
      @current += 1 # FIXME: Make it clear we're munching the newline here
      return val
    end

    def parse_operator_expression
      return OperatorExpression.new(
        left: parse_term,
        operator: parse_operator,
        right: parse_term
      )
    end

    def parse_term
      if @tokens[@current][0] == :NUMBER
        @current += 1
        return Number.new(value: @tokens[@current - 1][1])
      end
    end

    def parse_operator
      if @tokens[@current][0] == :+
        @current += 1
        return Operator.new(op: :+)
      end
    end

  end
end
