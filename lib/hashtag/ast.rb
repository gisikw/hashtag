module Hashtag
  module Ast
    def self.pretty_print(node, indent = "")
      string = "#{indent}#{node.class.name.split("::")[-1]}\n"
      node.class.members.each do |field|
        val = node.send(field)
        if val.is_a?(Array)
          string << "#{indent}  #{field}:\n"
          val.each do |n|
            string << pretty_print(n, "#{indent}    ")
          end
        elsif val.is_a?(Hashtag::Ast::Node)
          string << "#{indent}  #{field}:\n"
          string << pretty_print(val, "#{indent}    ")
        else
          string << "#{indent}  #{field}: #{val}\n"
        end
      end
      string
    end

    class Node < Struct
      def initialize h
        h.each_pair { |k, v| self[k] = v }
      end
    end
    class Program < Node.new(:expressions); end
    class OperatorExpression < Node.new(:left, :operator, :right); end
    class Number < Node.new(:value); end
    class Operator < Node.new(:op); end
  end
end
