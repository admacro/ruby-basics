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








