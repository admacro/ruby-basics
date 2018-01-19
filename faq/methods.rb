# coding: utf-8
# ruby

# method searching order
# receiver.singleton_methods
#   receiver.class_methods
#     receiver.super.class_methods

# singleton method
class Person
  def welcome
    p "Hi!"
  end
end

p1 = Person.new
p2 = Person.new
def p2.welcome # p2 welcomes differently (this method is called singleton method)
  p "Hello!"
end
p1.welcome
p2.welcome


# check class search order
p String.ancestors # => [String, Comparable, Object, Kernel, BasicObject]
p Thread.ancestors # => [Thread, Object, Kernel, BasicObject]
p (1..2).class.ancestors # => [Range, Enumerable, Object, Kernel, BasicObject]
p proc { p 1 }.class.ancestors # => [Proc, Object, Kernel, BasicObject]
p 23.class.ancestors # => [Fixnum, Integer, Numeric, Comparable, Object, Kernel, BasicObject]
p Class.ancestors # => [Class, Module, Object, Kernel, BasicObject]


# Above are the default search orders when a method is sent to the receiver.
# For example, s = "hi" and when s.capitalize is executed, Ruby searchs for
# capitalize method from s(for singleton methods), then String class, then
# Comparable, and so on.


# Adding new module to ancestors (class is not allowed)
module PrettyCapitalize
  def capitalize
    "**#{super}**" # this calls String#capitalize since PrettyCapitalize is prepended to String (see below)
  end
end

module Emphasizable
  def emphasize
    "*#{self}*" # self is the current object that calls emphasize method (the method receiver)
  end
end

l = "i love ruby"
p l.capitalize # => "I love ruby"
# p l.emphasize # undefined method `emphasize' for "i love ruby":String (NoMethodError)

class String
  include Emphasizable
  prepend PrettyCapitalize
end

p String.ancestors # => [PrettyCapitalize, String, Emphasizable, Comparable, Object, Kernel, BasicObject]

p l.capitalize # => "**I love ruby**"
p l.emphasize # => "*i love ruby*"



# operator overloading
# supported operators (they are actuallf methods): + - * / < > <=> (needs verification)
# unsupported operators: =, .., ..., not, ||, &&, and, or, ::

class Virus < String # Virus extends String
  def +(v) 
    "#{self}-#{v}"
  end
end

v1 = Virus.new("v1")
v2 = Virus.new("v2")
v3 = Virus.new("v3")
p v1 + v2 # => "v1-v2"
v3 += v2 # Ruby automatically handles +=, -=, etc.
p v3 # => "v3-v2"

