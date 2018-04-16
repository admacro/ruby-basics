# coding: utf-8
# ruby

# class extension, a special case of Object Extension (p130)
module MyModule
  def my_method
    'hello from module instance method'
  end
end

class MyClass
  # Add instance methods of MyModule to the class instance of MyClass class,
  # which means these methods actually become the class methods of MyClass.
  # This is the same as using 'extend'
  class << self # alternative: class << MyClass
    include MyModule
  end
end

puts MyClass.my_method


class MyClassExtend
  # extend adds the instance methods of the module to the class
  extend MyModule
end

puts MyClassExtend.my_method


class MyClassInclude
  # include adds the instance methods of the module to the instances of the class
  include MyModule
end

puts MyClassInclude.new.my_method
