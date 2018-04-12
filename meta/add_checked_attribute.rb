# coding: utf-8
# ruby

def add_checked_attribute(klass, attribute)
  attr_name = "@#{attribute}"
  
  Kernel.send :define_method, attribute do
    # gets value of the attribute, return nil if not exist
    klass.instance_variable_get attr_name
  end
  
  Kernel.send :define_method, "#{attribute}=".to_sym do |val|
    raise RuntimeError unless val
    # sets val to attribute, create and sets val if not exist
    klass.instance_variable_set attr_name, val
  end
end

load 'add_checked_attribute_test.rb'
