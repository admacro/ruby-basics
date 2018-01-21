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
# p2 welcomes differently (this method is called singleton method)
def p2.welcome
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


# No ++ and --, use += and -=
x = 1
x++ # no effect and Ruby doesn't rase an error
x += 2
p x
x -= 1
p x


# self
p self # => main
module M
  p self # => M

  class C
    p self # => M::C

    def f
      p self
    end

  end

  C.new.f # => #<M::C:0x007fc13a077800>
end


# access object's instance variables
class Person
  attr_reader :gender # read only
  attr_accessor :name # read and write
  attr_writer :something_weird # write only
  
  def initialize(gender)
    @gender = gender
  end
end

p = Person.new("male")
# p.gender = "female" # undefined method `gender=' for #<Person:0x007f8cde8358e8 @gender="male"> (NoMethodError)
p p.gender # => male

p p.name # => nil
p.name = "James"
p p.name # => "James"

p.something_weird = "unknown feature"
# p p.something_weird # undefined method `something_weird' for #<Person:0x007ffa7804db00> (NoMethodError)




