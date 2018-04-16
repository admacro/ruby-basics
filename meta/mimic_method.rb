# coding: utf-8
# ruby

# mimic method
#   Disguise a method as a language construct

class Object

  def BaseClass(name)
    name == 'string' ? String : Object;
  end

end

class Text < BaseClass 'string'
  attr_accessor :an_attribute
end

p Text.ancestors
# => [Text, String, Comparable, Object, Kernel, BasicObject]

obj = Text.new
obj.an_attribute = 1
puts obj.an_attribute
