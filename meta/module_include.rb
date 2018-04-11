# coding: utf-8
# ruby

module MyModule
  def my_method
    'hello from module instance method'
  end
end

class MyClass
  # this is same as using 'extend'
  class << self
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
