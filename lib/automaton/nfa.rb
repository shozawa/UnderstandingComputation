require 'set'

require_relative './fa_rule.rb'

class NFA < Struct.new(:current_states, :accept_states, :rulebook)
  def current_states
    rulebook.follow_free_moves(super)
  end

  def accepting?
    (current_states & accept_states).any?
  end

  def read_character(character)
    self.current_states = rulebook.next_states(current_states, character)
  end

  def read_string(string)
    string.chars.each do |character|
      read_character(character)
    end
  end
end

class NFADesign < Struct.new(:current_states, :accept_states, :rulebook)
  def accepts?(string)
    new_nfa.tap { |nfa| nfa.read_string(string) }.accepting?
  end

  def new_nfa
    NFA.new(current_states, accept_states, rulebook)
  end
end

class NFARuleBook < Struct.new(:rules)
  def next_states(states, character)
    states.flat_map { |state| follow_rules_for(state, character) }.to_set
  end

  def follow_free_moves(states)
    more_states = next_states(states, nil)

    if more_states.subset?(states)
      states
    else
      follow_free_moves(states + more_states)
    end
  end

  private

  def follow_rules_for(state, character)
    rules.select { |rule| rule.apply_to?(state, character) }.map(&:follow)
  end
end
