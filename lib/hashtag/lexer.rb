module Hashtag
  class Lexer
    RULES = [
      [ :NUMBER, /\d+/, ->(n) { n.to_i } ],
      [ :NEWLINE, /\n/ ],
      [ :+, /\+/ ]
    ]

    def initialize(source)
      @source = source
    end

    def next
      @unread ||= @source
      RULES.each do |name, regex, λ|
        match = /^\s*(#{regex})/.match(@unread)
        if match
          value = match[1]
          @unread.slice! value
          return [name, λ ? λ[value] : value]
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
