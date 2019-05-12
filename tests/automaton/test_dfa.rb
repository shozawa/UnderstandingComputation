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

class TestDFA < Test::Unit::TestCase
  def setup
    rule_book = DFARuleBook.new([
      FARule.new(1, 'a', 2),
      FARule.new(2, 'b', 3),
      FARule.new(3, 'c', 4),
    ])
    @dfa = DFA.new(1, [4], rule_book)
  end
  
  def test_accepting?
    assert_equal(DFA.new(1, [1, 3], nil).accepting?, true)
    assert_equal(DFA.new(1, [2, 3], nil).accepting?, false)
  end

  def test_simple_case
    assert_equal(@dfa.accepting?, false)
    @dfa.read_character('a')
    assert_equal(@dfa.accepting?, false)
    @dfa.read_character('b')
    assert_equal(@dfa.accepting?, false)
    @dfa.read_character('c')
    assert_equal(@dfa.accepting?, true)
  end
end
