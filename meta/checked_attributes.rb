# coding: utf-8
# ruby
#
# checked attributes (p140)
#
# It is a Class Macro.
# It should take the name of the attribute, as well as a block. The block is used
#   for validation. If you assign a value to the attribute and the block doesn’t
#   return true for that value, then you get a runtime exception.
# A class should gain access to attr_checked only when it includes a CheckedAttributes module

module CheckedAttributes
  def self.included(klass)
    klass.class_eval do
      def self.attr_checked(attribute, &validation)
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
end

load 'checked_attributes_test.rb'
