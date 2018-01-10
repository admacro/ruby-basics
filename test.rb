# ruby
a = 2
b = "flat white"
p a, b, 9 # prints each on a new line

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

dd = "a is #{a}"
p dd

ee = "tabbed\tlines"
puts ee # use puts instead of p here

p "length of ee is #{ee.length}"

p "3rd char of ee is #{ee[2]}"
p "4 chars from the 2nd char of ee is #{ee[1,4]}"

# string concatenation
jj = "aa" + "bb"
p jj

# replace substring
jj[2] = "d"
p jj
jj[0,2]="cc"
p jj

# search string
p jj.index("cd")
p jj.index("e")

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
p NIL.class

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
