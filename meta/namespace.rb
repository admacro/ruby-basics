# coding: utf-8
# ruby

# namespace (p238, 23)
#
# Define constants within a module to avoid name clashes.
# Class names are constants.

module Super
  class String
    def to_s
      "Super String"
    end
  end
end

puts "layman".to_s # => layman
puts Super::String.new.to_s # => Super String
