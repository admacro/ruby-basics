# coding: utf-8
# ruby

# This code doesn’t even need to call to class_eval, because when the method
# executes, the class is already taking the role of self.
#
# Just 'open' the Class class and define method in it.
# 
class Class

  # instance method of Class class (Yeah I already know it)
  def attr_checked(attribute, &validation)
    class_eval do
      attr_name = "@#{attribute}"
      
      define_method attribute do
        instance_variable_get attr_name
      end
      
      define_method "#{attribute}=".to_sym do |val|
        raise RuntimeError unless validation.call(val)
        instance_variable_set attr_name, val
      end
    end
  end
end

load 'attr_checked_macro_test.rb'
