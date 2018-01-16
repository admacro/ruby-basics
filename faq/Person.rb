# coding: utf-8
# ruby

class Person
  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    @age = age.to_i
  end

  def inspect
    "#{name} (#{age})"
  end
end

p = Person.new("James", 32)
p p # => James (32)
puts p # => #<Person:0x0000060029fa80>
print p # => #<Person:0x0000060029fa80>
print "\n"


# read data from person.txt and populate them
people = Array.new

File.foreach("persons.txt") do |line|
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


