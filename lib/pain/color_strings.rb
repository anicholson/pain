# frozen_string_literal: true

require 'term/ansicolor'

module Pain
  module ColorStrings
    refine String do
      include Term::ANSIColor
    end
  end
end
