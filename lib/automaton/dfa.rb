require_relative './fa_rule.rb'

class DFADesign < Struct.new(:current_state, :accept_states, :rulebook)
  def to_dfa
    DFA.new(current_state, accept_states, rulebook)
  end

  def accept(string)
    to_dfa.tap { |dfa| dfa.read_string(string) }.accepting?
  end
end

class DFA < Struct.new(:current_state, :accept_states, :rulebook)
  def accepting?
    accept_states.include?(current_state)
  end

  def read_string(string)
    string.chars.each do |c|
      read_character(c)
    end
  end

  private

  def read_character(character)
    self.current_state = rulebook.next_state(current_state, character)
  end
end

class DFARuleBook < Struct.new(:rules)
  def next_state(state, character)
    rule_for(state, character).follow
  end

  private

  def rule_for(state, character)
    rules.detect { |rule| rule.apply_to?(state, character) }
  end
end
