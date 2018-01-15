# coding: utf-8
# ruby

class Greeter
  def initialize(names = "World") # default arguments
    @names = names
  end

  def say_hi
    puts "Hello #{@names}!"
  end

  def say_bye
    puts "Bye #{@names}! Come back soon!"
  end 
end

g = Greeter.new # initialize without arguments
g.say_hi # parenthesis are optional
g.say_bye

gg = Greeter.new("James")
gg.say_hi()
gg.say_bye()

# gg.@name = "Russell" # syntax error, unexpected tIVAR, expecting '('
puts gg.respond_to?("names") # prints false
puts gg.respond_to?("say_hi") # prints true

# altering the class (when necessary)
# In Ruby, you can open a class up again and modify it.
# The changes will be present in any new objects you create
# and even available in existing objects of that class.
class Greeter
  attr_accessor :names # makes @names accessible to the outside

  # overrides say_hi
  def say_hi
    puts "Hi #{@names.capitalize}!"
  end 
end

puts gg.respond_to?("names") # prints true
gg.names = "russell" # changes @names to "Russell"
gg.say_hi
gg.say_bye



# Putting things together and make it mega

class MegaGreeter
  attr_accessor :names

  def initialize(names = "World")
    @names = names
  end
  
  def say_hi
    if @names.nil? # check if @names is nil
      puts "..."
    elsif @names.respond_to?("each") # see if @names can be iterated (Duck Typing)
      @names.each {
        |name|
        puts "Hello #{name}!!"
      }
    else
      puts "Hello #{names}!!"
    end
  end

  def say_bye
    if @names.nil? 
      puts "..."
    elsif @names.respond_to?("join") # can we join what's in @names together?
        puts "Bye #{names.join(", ")}!! Come back soon!!"
    else
      puts "Bye #{names}!! Come back soon!!"
    end
  end
end

# let's try it out
# Only run the following code when this file is the main file being run
# instead of having been required or loaded by another file

puts "Executing code in 20min.rb"
puts "__FILE__ is #{__FILE__}"
puts "$0 is #{$0}"

if __FILE__==$0
  mg = MegaGreeter.new
  mg.say_hi
  mg.say_bye

  mg.names = "James"
  mg.say_hi
  mg.say_bye

  mg.names = ["James", "Russell", "Tom"]
  mg.say_hi
  mg.say_bye

  mg.names = nil
  mg.say_hi
  mg.say_bye
end 

