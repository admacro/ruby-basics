# coding: utf-8
# ruby

# recommendation: return true or false for predicate methods
# return nil to indicate failure
p nil.class
p false.class

# true and false
p "" ? true : false # => true
p "".empty? # => true

# symbol
p "name".intern # => :name
p "name".intern.class # => Symbol
p "age".to_sym # => :age
p "age".to_sym.class # => Symbol

# symbols are created only once
persons = {:name => "James", :age => 32}
persons_1 = {name: "Russell", age: 6}
p persons # => {:name=>"James", :age=>32}
p persons_1 # => {:name=>"Russell", :age=>6}

# symbols used as enumeration values and constants values
status = :open # :closed, ...
NORTH_S = :NORTH
SOUTH_S = :SOUTH

p status # => :open
p status.to_s # => open
p "#{NORTH_S}" # => NORTH
p "#{:NORTH}" # => NORTH
p SOUTH_S # => :SOUTH


s = "Something"
es = eval("#{:s}")
bs = binding.local_variable_get(:s)
p s
p es
p bs
p s.object_id == es.object_id # => true
p s.equal?(es) # same as s.object_id == es.object_id
p es.equal?(bs) # => true


# use symbol for method invocation
def hi
  p "Hi!"
end

send(:hi) # at top-level (application scope), the method caller is Object
Object.send(:hi) # same as above
method(:hi).call # same as Object.method(:hi).call

class Demo
  def hello
    p "Hello"
  end
end

# send(:hello) # in `<main>': undefined method `hello' for main:Object (NoMethodError)
Demo.new.send(:hello)
Demo.new.method(:hello).call


# loop
# Although loop looks like a control structure, it is actually a method
# defined in Kernel. The block which follows introduces a new scope for
# local variables.
i = 0
loop do
  i = i + 1
  p i
  break if i == 5 # use break to exit
end


# emulate do {..} while
x = 0
begin
  p x
  x += 1
end until x == 5


# methods with = appended
class Person
  # attr_accessor :name
  
  def name=(name)
    @name = name
  end

  def inspect
    "P(#{@name})"
  end
end

pp = Person.new
pp.name = "James" # this invokes Person#name= method

p pp # => P(James)


# \\
a = '\a'
aa = '\\a'
p a # => "\\a"
p aa  # => "\\a"
p a.length # => 2
p aa.length # => 2
p a == aa # => true

b = "\b"
bb = "\\b"
p b # => "\b"
p bb # => "\\b"
p b.length # => 1
p bb.length # => 2
p b == bb # => false


# .. and ...
p 3..6 # => [3, 4, 5 , 6]
p 3...6 # => [3, 4, 5] right hand side of the range is excluded


# || and or
p nil || 23 # => 23
# p(nil or 23) # syntax error, unexpected keyword_or, expecting ')'
p((nil or 23)) # or has a very low precedence (parse precedence: || > = > or)

foo = nil || 23 # parsed as: foo = (nil || 23)
p foo # => 23

foo = nil or 23 # parsed as: (foo = nil) or 23
p foo # => nil

# or is similar to and. They are best used *not* for combining boolean expressions,
# but for control flow
p "success" or raise "some error!"
p nil or raise "some error!" # in `<main>': some error! (RuntimeError)

