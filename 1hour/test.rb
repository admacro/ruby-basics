# coding: utf-8

# ruby
a = 2
b = "flat white"
p a, b, 9 # prints each on a new line

# return printed objects
# either as it is when there is only one object
# or, return all in an array if there are more than one object
(p a) # => 2
(p a).class # => Integer
(p b) # => flat white
(p b).class # => String
(p true).class # => TrueClass
(p nil).class # => NilClass
(p a,b,false).class # => Array

=begin
multil-line comment starts with "=begin" and ends with "=end"
p a, b, 3

can be written as

p(a, b, 3)

parenthesis are often not necessary
=end

puts(a, b)
print 1
print "\n"

ss = 'newline \n is printed as is and backslash is escaped'
p ss

tt = 'multi-line
string in
single quotes
contains \n'
p(tt)

# string concatenation
# interpolation
#
# speed comparison: (<< ≥ concat) >> (+ ≈ interpolation) (>> means much greater than, like 10000x)
# better use concat or << if there is concatenation in loop
dd = "a is #{a}"
p dd

ee = "tabbed\tlines"
puts ee # use puts instead of p here

p "length of ee is #{ee.length}"

p "3rd char of ee is #{ee[2]}"
p "4 chars from the 2nd char of ee is #{ee[1,4]}"

# String#concat
# Takes multiple params, and integers are treated as code point
# faster than +
p h = 'Hello'
p hh = h.concat(' world', 33) # => Hello world!
p h # => Hello # changes the object to which the params are concatenated

# use + method
jj = "aa" + "bb"
p jj

# replace substring
jj[2] = "d"                     # method: str[index]
p jj
jj[0,2]="cc"                    # method: str[start, length]
p jj

# search string
p jj.index("cd")
p jj.index("e")                 # nil if not found, not -1

# split string
p jj.split("d") # => ["cc", "b"]

# type conversion
p "3".to_i # convert to int 3
p "3".to_f # convert to float 3.0
p 0.to_s # convert to string "0"
p 2.to_f # convert to float 2.0

puts "5/2 is #{5/2}"
puts "5/2.0 is #{5/2.0}"


# find methods
puts "methods for int objects are:\n #{3.methods}" # all methods of int are listed


# class and object
p 4.kind_of?(Integer)
p 9.class
p 'o'.class
p "oo".class
p 8.0.class
p [a, ee].class
p true.class # either upper or lower case, no mixed case like True
p FALSE.class
p nil.class
p NIL.class                     # warning: constant ::NIL is deprecated, use nil


name = 'James'
age = 30
txt = "hello my name is #{name}, and I'm #{age}." # txt is interpreted here, it's not a template
p txt[18, 6]
puts txt

txt[0] = "H"
txt[txt.length - 1] = " years old."
txt[txt.index(','), 6] = ". \n"
age = age + 2.4
p age
puts txt # age will not be updated in txt as it's been interpred

print "ss".methods
print "\n"


### Variables

iAge = 32 # local variables start with lower case letter or _
_temp = "/tmp"
File_Path = "/opt/" # constants start with UPPER case letter
File_Path = _temp # warning: already initialized constant File_Path
$Operating_System = "WinNT" # global variables start with $
@name = "James" # instance variables start with @
@@gender = "male" # class variables start with @@ (static fields in Java)

p defined? iAge                 # local-variable
p defined?(_temp)               # local-variable
p defined? (File_Path)          # constant
p defined?($Operating_System)   # global-variable
p defined?(@name)               # instance-variable
p defined?(@@gender)            # class-variable

# Predefined Global Variables
puts "current file name is #{$0}"
puts "invoking arguments are #{$*}"
puts "current process ID is #{$$}"
puts "exit status of last executed child process is #{$?}"

# true and false
# all are true except nil and false
p nil ? true : false
p false ? true : false
p 0 ? true : false
p "false" ? true : false
p " " ? true : false
p [] ? true : false

# conditional if then else
if age > 30 then p "old" end
if age > 40 then p "old" else p "young" end
if age > 60 then p "too old"
elsif age > 40 then p "old"
else p "young"
end

# use as expression
p (if age > 30 then "old" end) # parenthesis () must be used here

g = 
case @@gender
  when "male" then "men"
  when "female" then "women"
  else "alien"
end 

p g


### Range and Loop
for i in -2..2 do p i end # prints -2, -1, 0, 1, 2

for x in -1..1 do
  for y in 0..2 do
    p "(#{x}, #{y})"
  end
end

rr = 0..5
aa = rr.to_a # create array from range
p rr.class # Range
p aa.class # Array
p aa.reverse! # prints [5, 4, 3, 2, 1, 0]

### Array
mud = [name, age, rr, aa]
p mud
p mud.length
p mud.reverse!
p mud[-1] # prints value of #{name} (valid index range: -length, length - 1, eg. [-4, 3])
p mud[0][1]
p mud.index(32.4)
p mud[1, 2] # sub array, similar to substring Array#[start, length]

# modify array
p mud[2] = 32 # updates and returns the new element
p mud.insert(2, @@gender) # note the insert method returns the updated array
p mud.delete_at(mud.length - 1) # deletes and returns the deleted element
p mud << "temp" # appends and returns the updated array
p mud.push("TEMP") # same as append
p mud.pop # removes and returns the last element

# * - unary (or un-array )/splat
# converts array into a list of separate values
numbers = (0..9).to_a
p numbers.pop(2) # => [8,9] removes the last 2 element, and return the 2 elements in an array
p numbers.push *[8,9] # append 8 and 9 to the array
p numbers.shift(3) # => [0,1,2] removes the first 3 element, and return the 3 elements in an array
p numbers.unshift *(0..2).to_a # prepend (same as #prepend in Ruby2.5)
p numbers.append(*(10..20).to_a) # >= Ruby 2.5 (same as #push)
p numbers.prepend(-1) # >= Ruby 2.5 (same as #unshift)
p numbers

# Array#new(size=0, default=nil)
aaa = Array.new(3) # creates an array of three nil elements [nil, nil, nil]
bbb = Array.new(3, 4) # creates an array of three nil elements [4, 4, 4]
p aaa
p bbb
p Array.new(bbb << 5)

ddd = aaa + bbb + aa # join arrays
p ddd

p aa
p aa - bbb # difference, remove all elements of bbb from aaa
p aa & bbb # intersection, keep common elements of aaa and bbb

# union. note order matters. duplicate elements are removed
ccc = [3, 4, 5]
p bbb | ccc # prints [4, 3, 5]
p ccc | bbb # prints [3, 4, 5]

# unique element
p ddd.uniq # returns a new array with uniqu elements. original array not modified
p ddd
p ddd.uniq! # makes the array uniqu and return it. original array modifided.
p ddd

ddd.delete_at(0)
p ddd.sort # sorts and returns a new array with sorted elements
p ddd
p ddd.sort! # sorts the original array and returns it
p ddd

# array comparsison
aa = [0, 1, 2]
bb = [0, 1, 2.0]
cc = [0, 1, "2"]

p aa == bb # => true, because 2 == 2.0 is true
p aa == cc # => false

# hash table (dictionary)
ht = {:james => 30, :russell => 6}
p ht

p ht[:james] # get value by key

p ht[:james] = 32 # update and returns the value
p ht

p ht[:tom] = 21 # adds and returns the new entry value
p ht

p ht.delete(:tom) # deletes the entry and returns the value of the deleted entry 
p ht

p ht.keys # all keys
p ht.values # all values

p ht.has_key?(:james) # prints true
p ht.has_value?(21) # prints false

# :symbol type
ss = :chicken
ht[ss] = 1
p ht

### calling unix command with backticks `...`
puts `pwd`
puts `ls -l`

### function
def f(x) x + 1 end
puts f(1)

# function with default value
def df(x = 100) x + 1 end
puts df
puts df(1000)

# function with unspecified number of parameters
def ff(*args)
  args.each{|arg| puts arg}
end
ff
ff("james", "russell")
ff(2,4,6)
ff(*'hello'.chars)


module Clazz
  ### class and object
  class Laptop
    @@keyboard = "Standard"

    def initialize(brand)
      @brand = brand
    end

    def get_brand
      @brand
    end

    def get_keyboard
      @@keyboard
    end

    def desc(user)
      "This is #{user}'s laptop."
    end
  end

  # create an object
  dell = Laptop.new("Dell")

  p dell.get_brand
  p dell.get_keyboard
  p dell.desc("James")

end
