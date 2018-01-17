# coding: utf-8
# ruby

# p e # undefined local variable or method `e' for main:Object (NameError)

i = 1234567
ii = 1234567
p i.equal?(ii) # => true

f = 123.456
ff = 123.456
p f.equal?(ff) # => true

s = "string"
ss = "string"
p s == ss # => true
p s.equal?(ss) # => false


# Variable scope
v = 1 # top level
class Demo
  v = 2 # class (or moduel) level
  def method
    v = 3
    puts "in method: v = #{v}"
  end
  puts "in class: v = #{v}" # class definition is executable code
end
puts "at top level: v = #{v}"
Demo.new.method

# block {..} and do..end
threads = []
["one", "two"].each do |name|
  threads << Thread.new do
    l_name = name
    a = 0 # each thread receives its own copy of the variables local to the thread's block
    3.times do |i|
      Thread.pass
      a += i
      puts "#{l_name}: #{a}"
    end 
  end
end 

threads.each {|t| t.join}


# until, unless
x = 5
until x == 0 do
  p x unless x % 2 == 0
  x -= 1
end

# upto
1.upto 3 do |i| p i end


# variable detecting
def a
  puts "method a called"

  99
end

[1, 2].each { |i|
  if i == 2
    puts "a = #{a}"
  else
    a = 1
    puts "a = #{a}"
  end
}

# CONSTANTS
module M1
  M_CONST = "I love Ruby!"
  class C1
    C_CONST = "I love Ruby more!"
  end
end

p M1::M_CONST
p M1::C1::C_CONST

# variable passing (object references are passed)
# There is no equivalent of other language’s pass-by-reference semantics.
def downer(string)
  string.downcase! # a string object is mutable
end
s = "HELLO"
p s
downer(s)
p s # => "hello


# * (asterisk)
def say_hi(word, *names, punc)
  names.each do |name|
    p "#{word} #{name}#{punc}"
  end                
end

say_hi("Hello", "James", "Russell", "!") # "James", "Russell" is passed as an array to names

def say_hi(word, name, punc)
  p "#{word} #{name}#{punc}"
end

a = ["Hello", "James", "!!!"]
say_hi(*a) # * expands a to three arguments "Hello", "James", "!!!"


# & (ampersand)
def arr_map(a, &f)
  if !a.nil? && a.respond_to?("each")
    a.each do |e|
      # lambda aned proc are both objects of Proc (Procedure)
      p f.class # => Proc
      f.call(e) # Proc.call
      # yield(e) is another way to call f
    end
  end
end

arr = [1, 2, 3]
# block ({..} and do..end)
# con: only one block can be passed to the method
arr_map(arr) { |x|
  p x + 1
} # block will be converted to a Proc object and assigned to f

# proc
sqr = proc {|i| p i * i} # another way is Proc.new {..}
arr_map(arr, &sqr)

# lambda
third_p = lambda {|i| p i * i * i}
arr_map(arr, &third_p)

# multiple arguments
mp = proc {|x, y| x * x + y * y}


# Variables hold references to objects
A = a = b = "abc"
b.concat("def")
p A, a, b
