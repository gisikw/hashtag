require 'test_helper'

class LexerTest < Minitest::Test

  def lex_for(src)
    Hashtag::Lexer.new(src)
  end

  def test_it_provides_source
    lex = lex_for("3 + 4")
    assert_equal "3 + 4", lex.source
  end

  def test_next_emits_tokens
    lex = lex_for("3 + 4")
    assert_equal [:NUMBER, 3], lex.next
    assert_equal [:BINOP, "+"], lex.next
    assert_equal [:NUMBER, 4], lex.next
    assert_nil lex.next
  end

  def test_tokens_returns_all_tokens
    lex = lex_for("3 + 4")
    assert_equal [
      [:NUMBER, 3],
      [:BINOP, "+"],
      [:NUMBER, 4]
    ], lex.tokens
  end
end
