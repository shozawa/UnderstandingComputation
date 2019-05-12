require 'set'

require_relative './fa_rule.rb'

class NFA < Struct.new(:current_states, :accept_states, :rulebook)
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

class NFARuleBook < Struct.new(:rules)
  def next_states(states, character)
    states.flat_map { |state| follow_rules_for(state, character) }.to_set
  end

  private

  def follow_rules_for(state, character)
    rules.select { |rule| rule.apply_to?(state, character) }.map(&:follow)
  end
end
