require 'set'

require_relative './fa_rule.rb'

class NFARuleBook < Struct.new(:rules)
  def next_states(states, character)
    states.flat_map { |state| follow_rules_for(state, character) }.to_set
  end

  private

  def follow_rules_for(state, character)
    rules.select { |rule| rule.apply_to?(state, character) }.map(&:follow)
  end
end
