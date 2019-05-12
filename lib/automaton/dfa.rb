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

class FARule < Struct.new(:state, :character, :next_state)
  def apply_to?(state, character)
    self.state == state && self.character == character
  end

  def follow
    next_state
  end

  def inspect
    "#<FARule #{state.inspect} --#{character}--> #{next_state.inspect}>"
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
