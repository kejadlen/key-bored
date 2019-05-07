require_relative "../test_helper"

require "key_bored/sexp"

class TestSExp < Minitest::Test
  def assert_parsed(expected, input)
    assert_equal expected, KeyBored::SExp.parse(input).to_a
  end

  def test_sexp
    assert_parsed [], "()"
    assert_parsed [ "abc" ], "(abc)"
    assert_parsed [ "abc" ], "(abc)(def)"
    assert_parsed [ "abc", "def" ], "(abc def)"
    assert_parsed [ "abc", [ "def" ] ], "(abc (def))"
    assert_parsed [ [ "abc" ], [ "def" ] ], "((abc) (def))"
    assert_parsed [ "abc def" ], '("abc def")'
    assert_parsed [ "abc\"def" ], '("abc\"def")'

    assert_raises(RuntimeError) { KeyBored::SExp.parse("(abc") }
    assert_raises(RuntimeError) { KeyBored::SExp.parse("a") }
  end
end
