module Hashtag
  class Parser
    class ParserError < StandardError; end
    include Ast

    # <Program> ::= <Line>+
    # <Line> ::= <Expression> NEWLINE
    # <Expression> ::= <Term> + <Expression>
    #                | <Term> - <Expression>
    #                | <Term>
    # <Term> ::= <Factor> * <Expression>
    #          | <Factor> / <Expression>
    #          | <Factor>
    # <Factor> ::= (<Expression>)
    #            | Literal

    def parse(tokens)
      @tokens = tokens
      @index = 0
      parse_program
    end

    def current_token
      @tokens[@index]
    end

    def chomp(*expected)
      type, value = current_token
      if expected.include?(type)
        @index += 1
        value
      end
    end

    def chomp!(*expected)
      result = chomp(*expected)
      type, value = current_token
      if !result
        raise ParserError,
          "Expected #{expected.join(" or ")} token, but saw #{type}"
      end
      result
    end

    def parse_program
      expressions = []
      while current_token && expression = parse_line
        expressions << expression
      end
      Program.new(expressions: expressions)
    end

    def parse_line
      expression = parse_expression
      chomp!(:NEWLINE)
      expression
    end

    def parse_expression
      term = parse_term
      type, value = current_token
      if chomp(:PLUS, :MINUS)
        BinaryOperation.new(
          left: term,
          operator: type,
          right: parse_expression
        )
      else
        term
      end
    end

    def parse_term
      factor = parse_factor
      type, value = current_token
      if chomp(:MULT, :DIV)
        BinaryOperation.new(
          left: factor,
          operator: type,
          right: parse_factor
        )
      else
        factor
      end
    end

    def parse_factor
      if chomp(:LPAREN)
        expression = parse_expression
        chomp!(:RPAREN)
        expression
      elsif value = chomp(:NUMBER)
        Literal.new(value: value)
      end
    end

  end
end
