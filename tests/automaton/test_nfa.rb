require 'set'
require 'test/unit'

require './lib/automaton/fa_rule.rb'
require './lib/automaton/nfa.rb'

class TestNFA < Test::Unit::TestCase
  def test_simple_case
    rulebook = NFARuleBook.new(
      [
        FARule.new(1, 'a', 2),
        FARule.new(2, 'a', 100),
        FARule.new(2, 'b', 3),
        FARule.new(3, 'c', 3)
      ]
    )
    nfa = NFA.new(Set.new([1]), Set.new([100]), rulebook)
    nfa.read_string('aa')
    assert_equal(true, nfa.accepting?)
  end
end

class TestNFARuleBook < Test::Unit::TestCase
  def test_simple_case
    rulebook = NFARuleBook.new(
      [
        FARule.new(1, 'a', 2),
        FARule.new(2, 'a', 100),
        FARule.new(2, 'b', 3),
        FARule.new(3, 'c', 3)
      ]
    )
    assert_equal(Set.new([2, 100]), rulebook.next_states([1, 2], 'a'))
  end
end
