# coding: utf-8
# ruby

# class taboo (p112)
# taboo: class

MyClass = Class.new(Array) do
  def my_method
    'Hello!'
  end
end

my_object = MyClass.new
puts my_object.my_method

puts MyClass.superclass
