require 'test_helper'

class LexerTest < Minitest::Test

  def lex(src)
    Hashtag::Lexer.new(src).tokens
  end

  def test_tokens_returns_all_tokens
    code = lex("3 + 4\n")
    tokens =
      [
        [:NUMBER, 3],
        [:+, "+"],
        [:NUMBER, 4],
        [:NEWLINE, "\n" ]
      ]
    assert_equal code, tokens
  end

end
