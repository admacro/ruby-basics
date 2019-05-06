# coding: utf-8
# ruby

class Person
  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    @age = age.to_i
  end
end

person = Person.new("James", 32)

# The print method p is a kernel method.
# Kernel.p(obj) writes obj.inpect which by default shows
#   #<ClassName:Encoding_of_the_Object_ID @instance_variable_1=value_1 ...>
#   in which value_1, value_2, etc are obtained by calling #inspect on each of the
#   instance variables.
p person # => #<Person:0x00007f8a959c9d30 @name="James", @age=32>

class Person
  # overriding Object#inspect
  def inspect
    # here #{name} calls name.to_s, not name.inspect
    "#{name} (#{age})"
  end
end

p person # => #<Person:0x00007f8a959c9d30>[James (32)]

# Kernel.puts(obj) writes obj.to_s
puts person # => #<Person:0x0000060029fa80>

class Person
  # overriding Object#to_s
  def to_s
    # here #{name} calls name.to_s, not name.inspect
    "#{name} is #{age} years old."
  end
end

# Kernel.print(obj) writes obj.to_s
print "#{person}\n" # => James is 32 years old.


# read data from person.txt and populate them
people = Array.new

File.foreach("persons.txt") do |line|
  # =~ tests regex
  # $1 and $2 are back references of the regexen
  people << Person.new($1, $2) if line =~ /(.*):\s+(\d+)/
end

p people

# sort
ps = people.sort {|a, b| a.age <=> b.age }
p ps

# add comparison method to class
class Person
  def <=>(other)
    age <=> other.age
  end
end

pp = people.sort
p pp

=begin
about the <=> (spaceship) operator
Perl was likely the first language to use it. Groovy is another language that supports it. 
Basically instead of returning 1 (true) or 0 (false) depending on whether the arguments are
equal or unequal, the spaceship operator will return 1, 0, or −1 depending on the value of 
the left argument relative to the right argument.
a <=> b means
if a < b then return -1 end
if a = b then return 0 end
if a > b then return 1 end
if a and b are not camparable then return nil end
=end
