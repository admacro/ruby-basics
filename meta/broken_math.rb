# coding: utf-8
# ruby

# Quiz: make 1 + 1 = 3 (p136)
#
# Spell used: around alias

class Fixnum
  # syntax: alias_method :alias, :real
  # works like adding a new pointer pointing to the real method
  alias_method :add, :+

  # afte refining the method, :+ no longer points to the original method,
  # whil :add still does.
  def +(term)
    self.add(term).add(1)
  end
end

puts 2.add(5) # => 7
puts 2 + 5 # => 8
