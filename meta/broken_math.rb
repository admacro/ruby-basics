# coding: utf-8
# ruby

# Quiz: make 1 + 1 = 3 (p136)
#
# Spell used: around alias

class Fixnum
  alias_method :add, :+
  def +(term)
    self.add(term).add(1)
  end
end

puts 2.add(5) # => 7
puts 2 + 5 # => 8
