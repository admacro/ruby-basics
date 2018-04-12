# coding: utf-8
# ruby

def add_checked_attribute(klass, attribute, &validation)

  # compare with using Kernel.send in add_checked_attribute.rb,
  # you can use class_eval to get into the class scope of a class
  klass.class_eval do
    attr_name = "@#{attribute}"
    
    define_method attribute do
      klass.instance_variable_get attr_name
    end
    
    define_method "#{attribute}=".to_sym do |val|
      raise RuntimeError unless validation.call(val)
      klass.instance_variable_set attr_name, val
    end
  end
end

load 'add_checked_attribute_block_test.rb'
