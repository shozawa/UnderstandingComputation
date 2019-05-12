require 'test/unit'

require './lib/automaton/dfa.rb'

class TestFARuleBook < Test::Unit::TestCase
  def setup 
    @rule_book = DFARuleBook.new([
      FARule.new(1, 'a', 2),
      FARule.new(2, 'a', 2),
      FARule.new(2, 'b', 3),
    ])
  end

  def test_simple_case
    assert_equal(@rule_book.next_state(1, 'a'), 2)
    assert_equal(@rule_book.next_state(2, 'a'), 2)
    assert_equal(@rule_book.next_state(2, 'b'), 3)
  end
end
