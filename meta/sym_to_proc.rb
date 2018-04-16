# coding: utf-8
# ruby

# symbol to proc (p225)
# Symbol#to_proc converts a symbol to a proc object
#
# & converts any object with the object's to_proc method to a Proc object, which means 
# you can define a to_proc method in any class you want, and then use & on any object
# of the classes.

class Person
  attr_accessor :name

  def initialize(name)
    @name = name
  end
  
  def say_hi
    puts "hi, I'm #{@name}"
  end

  def Person.to_proc
    Proc.new { |name| Person.new(name) }
  end
end


# &Person =>
#   call Person.to_proc
#   converts the Proc object to a block
#   pass the block to map
#
# &:say_hi =>
#   call :say_hi.to_proc (:say_hi is a Symbol object)
#   converts the Proc object to a block
#   pass the block to map
['James', 'Russell', 'Tom'].map(&Person).map(&:say_hi)
