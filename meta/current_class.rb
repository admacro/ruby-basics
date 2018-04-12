# coding: utf-8
# ruby

class MyClass

  # self is the current class
  puts self == MyClass # => true
  
  def my_method
    
    # self is the current object
    puts self == MyClass # => false
    
    # Methods defined in my_method will only be created
    # after my_method is called
    
    # another instance method of MyClass
    def my_nested_method
      'hello in nested method'
    end

    # singleton method of the curret object
    def self.my_nested_class_method
      'hello in nested class method'
    end
    
    'hello'
  end
end

obj = MyClass.new
# puts obj.my_nested_method # => undefined method `my_nested_method'

puts obj.my_method
puts obj.my_nested_method
puts obj.my_nested_class_method

puts obj.singleton_class # => #<Class:#<MyClass:0x007f7f23101c70>>
puts obj.singleton_methods # => my_nested_class_method

p MyClass.instance_methods false # => [:my_method, :my_nested_method]
p MyClass.methods false # => []
