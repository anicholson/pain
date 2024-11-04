# frozen_string_literal: true

require 'term/ansicolor'

module Pain
  module ColorStrings
    refine String do
      Term::ANSIColor.public_instance_methods.each do |method|
        define_method(method) do |*args|
          Term::ANSIColor.send(method, *args).to_s
        end
      end
    end
  end
end
