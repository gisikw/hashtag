require 'test_helper'

class LexerTest < Minitest::Test

  def assert_lexes_to(code, tokens)
    assert_equal tokens, Hashtag::Lexer.new(code).tokens
  end

  def test_tokens_returns_all_tokens
    assert_lexes_to("3 + 4 - 5 * (2 / 3)\n",
      [
        [:NUMBER, 3],
        [:PLUS, "+"],
        [:NUMBER, 4],
        [:MINUS, "-"],
        [:NUMBER, 5],
        [:MULT, "*"],
        [:LPAREN, "("],
        [:NUMBER, 2],
        [:DIV, "/"],
        [:NUMBER, 3],
        [:RPAREN, ")"],
        [:NEWLINE, "\n" ],
      ]
    )
  end

  def test_newline_captures_work_despite_regex
    assert_lexes_to("3\n4\n5\n",
      [
        [:NUMBER, 3],
        [:NEWLINE, "\n"],
        [:NUMBER, 4],
        [:NEWLINE, "\n"],
        [:NUMBER, 5],
        [:NEWLINE, "\n"]
      ]
    )
  end

end
