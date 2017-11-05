module Hashtag

  # TODO: Move this to its own file
  module Ast
    # Make it easier to visualize trees
    # This shouldn't override inspect. There should be an inspect(tree) =>
    # pretty_tree method for testing. The initialize shorthand is worthwhile though.
    class Node < Struct
      def initialize h
        h.each_pair do |k, v|
          self[k] = v if members.map {|x| x.intern}.include? k
        end
      end
      def inspect
        string = "<#{self.class.name.split("::")[-1]} "
        fields = self.class.members.map{|field| "#{field}: #{self.send(field)}"}
        string << fields.join(", ") << ">"
      end
      def to_s; inspect; end
    end

    class Program < Node.new(:expressions); end
    class OperatorExpression < Node.new(:left, :operator, :right); end
    class Number < Node.new(:value); end
    class Operator < Node.new(:op); end
  end

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
