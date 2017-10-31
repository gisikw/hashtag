module Hashtag
  class Lexer
    RULES = [
      [ :NUMBER, /\d+/, ->(n) { n.to_i } ],
      [ :BINOP, /[\+\-\/\*]/, ->(s) { s } ]
    ]

    attr_accessor :source

    def initialize(source)
      @source = source
    end

    def next
      @unread ||= @source
      RULES.each do |name, regex, λ|
        match = /^\s*(#{regex})/.match(@unread)
        if match
          @unread.slice! match[1]
          return [name, λ[match[1]]]
        end
      end
      nil
    end

    def tokens
      result = []
      while token = self.next
        result.push(token)
      end
      result
    end

  end
end
