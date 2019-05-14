require 'set'
require 'test/unit'

require './lib/automaton/fa_rule.rb'
require './lib/automaton/nfa.rb'

class TestNFA < Test::Unit::TestCase
  def setup
    rulebook = NFARuleBook.new(
      [
        FARule.new(1, 'a', 1),
        FARule.new(1, 'b', 1),
        FARule.new(1, 'b', 2),
        FARule.new(2, 'a', 3),
        FARule.new(2, 'b', 3),
        FARule.new(3, 'a', 4),
        FARule.new(3, 'b', 4)
      ]
    )
    @design = NFADesign.new(Set.new([1]), Set.new([4]), rulebook)
  end

  def test_simple_case
    assert_equal(true, @design.accepts?('baa'))
    assert_equal(true, @design.accepts?('bbbbb'))
    assert_equal(false, @design.accepts?('abb'))
  end
end

class TestFreeMove < Test::Unit::TestCase
  def setup
    rulebook = NFARuleBook.new(
      [
        FARule.new(1, nil, 2),
        FARule.new(1, nil, 4),
        FARule.new(2, 'a', 3),
        FARule.new(3, 'a', 2),
        FARule.new(4, 'a', 5),
        FARule.new(5, 'a', 6),
        FARule.new(6, 'a', 4),
      ]
    )
    @design = NFADesign.new(Set.new([1]), Set.new([2, 4]), rulebook)
  end

  def test_simple_case
    assert_equal(true, @design.accepts?('aa'))
    assert_equal(true, @design.accepts?('aaa'))
    assert_equal(true, @design.accepts?('aaaa'))
    assert_equal(false, @design.accepts?('aaaaa'))
  end
end

class TestFreeMove < Test::Unit::TestCase
  def test_current_state
    rulebook = NFARuleBook.new(
      [
        FARule.new(1, nil, 2),
        FARule.new(1, nil, 3)
      ]
    )
    nfa = NFA.new(Set.new([1]), Set.new([2]), rulebook)
    assert_equal(Set.new([1, 2, 3]), nfa.current_states)
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
