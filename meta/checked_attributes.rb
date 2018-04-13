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

# This is my solution. It's different with the solution in the book using Object#extend (p162).
# Both my solution and the solution in the book pass the test (of course).
#
# So what's the difference?
# I had this question in my mind and found someone asked the same question on Nov 9, 2009. :D
#   https://stackoverflow.com/questions/1710841/base-extend-vs-base-class-eval-extend
#
# Anwser from the above page.
#   The only relevant difference is that only classes respond to "class_eval", whereas
#   both classes and instances respond to "extend".
#   If you don't plan on using your method with object instances, then they are equivalent,
#   though the second implementation can be used to add instance methods to a particular
#   instance, while the first one cannot.
#
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
