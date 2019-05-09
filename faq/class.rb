# coding: utf-8
# ruby

# repeated class defition
class Clazz
  @@version = 1.0
  def Clazz.version # class methods
    p "Version #{@@version}"
  end

  def beta
    p "Beta #{@@version}"
  end
end
Clazz.version # => "Version 1.0"
Clazz.new.beta # => "Beta 1.0"

# class method cannot be called on instances
# Clazz.new.version # undefined method `version' for #<Clazz:0x0000060029fd00> (NoMethodError)

# self in class defition
class Clazz
  @@version = 2.0
  def self.version # overrides former definition of Clazz.version
    p "#{self} V#{@@version}"
  end
end
Clazz.version # => "Clazz V 2.0"


# class variable and instance variable
class Vars
  # class variables belong to class object (Vars), which is an instance of class Class
  @@class_var = "@@class_var" # belongs to Vars (an instance of Class) and instances of Vars
  @class_var = "@class_var" # only belongs to Vars (an instance of Class)

  def initialize(inst_var)
    @inst_var = inst_var # instance variables that are initialized when new instance is created
  end

  def temp
    @temp_inst_var = "@temp_inst_var" # @temp_inst_var will be initialized when temp is first called
  end

  def inspect
    a = [@@class_var, @class_var, @inst_var, @temp_inst_var]
    "#{self} #{a}"
  end

  def self.inspect
    a = [@@class_var, @class_var, @inst_var, @temp_inst_var]
    "#{self} #{a}"
  end
end

v = Vars.new("instance var")

# Only class variable start with @@ are identified in instance methods
# here only @@class_var is printed but @class_var is omitted
# *TIP*: always follow naming conventions
p v # => #<Vars:0x0000060029d140> ["@@class_var", nil, "instance var", nil]

# both @@class_var and @class_var are identified in class methods
# but instance variables are dismissed
puts Vars.inspect # => Vars ["@@class_var", "@class_var", nil, nil]

# @temp_inst_var is nil until Var#temp is called
v.temp
p v # => #<Vars:0x0000060029d140> ["@@class_var", nil, "instance var", "@temp_inst_var"]


# singleton class
# singleton methods are methods that live in the singleton class
class Person
  def welcome
    p "hi"
  end
end
p = Person.new
p.welcome # => "hi"

# optional one
class << p
  def welcome
    p "hello"
  end
end
p.welcome # => "hello"

# optional two (clearer and simpler, but is prone to be overlooked)
def p.welcome
  p "Bonjour"
end
p.welcome



# Module
module Formatter
  PATTERN = "XXXYYY"
  def self.format # just like class methods
    p PATTERN
  end
  def Formatter.format_pretty # same as self.format_pretty
    p "##{PATTERN}#"
  end
end

# use :: to access anything of module
Formatter::PATTERN
Formatter::format
Formatter::format_pretty

# modules cannot generate instances
# f = Formatter.new # => undefined method `new' for Formatter:Module (NoMethodError)

p Math::PI

# module cannot inherit from anything, nor can be inherited (subclassed)
# syntax error, unexpected '<'
# module MyMath < Math 
# end



# mixin
# module can be mixed with a class or another module
class Animal
  include Comparable # provides <, <=, ==, >=, >, between?, but no <=> 

  attr_reader :legs

  def initialize(name, legs)
    @name, @legs = name, legs
  end

  # Must be defined to use <, <=, ==, >=, >, and between?
  # It is used by Comparable to provide its functionalities
  # <=> is used in <, <=, ==, >=, >, and between? in Comparable
  # In the following examples, "comparing" will be printed when
  # comparing using <, <=, ==, >=, >, or between?
  def <=>(other)
    p 'comparing'
    legs <=> other.legs
  end

  def inspect
    @name
  end
end

c = Animal.new("cat", 4)
s = Animal.new("snake", 0)
p = Animal.new("parrot", 2)

p c < s # => false and "comparing"
p s < c # => false and "comparing"
p p >= s # => false and "comparing"
p p.between?(s, c) # => false and twice of "comparing"
p ([c, s, p].sort) # => [snake, parrot, cat] (parentheses are required as p is ambiguous) and 3 times of "comparing"


# alternate class method definition
class CC
  CT = 1
  def CC.mm
    CT # CT can be used directly
  end
end

def CC.mmm
  CC::CT # must use Class::CONST notation, otherwise NameError: uninitialized constant CT
end

p CC.mm # => 1
p CC.mmm # => 1


# include a module
include Math
p sqrt(9) # => 3.0 (notice method receiver is omitted)

# extend a module
# when x extend a module m, x will have and only have all the instance methods in m, module methods are ignored
module Formatter
  def format_simple # instance method
    "simple"
  end
end
c = CC.new
c.extend Formatter

# Only instance methods are added to this particular object
# Here the object is an instance of CC class
p c.format_simple # => simple

# And instance methods are added to the object as singleton methods
p c.singleton_methods # => [format_simple]

# won't work since this is another object
# p CC.new.format_simple # undefined method `format_simple' for #<CC:0x000006002886c8> (NoMethodError)

# won't work for module methods 
# p c.format # private method `format' called for #<CC:0x00000600288880> (NoMethodError)

# Instance methods are now added to Person (an instance of class Class) as
# singleton methods (also called Class methods)
Person.extend Formatter
p Person.format_simple 
p Person::format_simple # same as above
p Person.singleton_methods # => [format_simple]

# won't work for instances
# p Person.new.format_simple # undefined method `format_simple' for #<Person:0x000006002884e8> (NoMethodError)

