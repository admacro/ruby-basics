# coding: utf-8
# ruby

# code processor; eval (p233, 144)
#
def add_checked_attribute(klass, attribute)
  code = <<-end_eval
       class #{klass}
         def #{attribute}; @#{attribute}; end
         def #{attribute}=(val)
           raise RuntimeError unless val
           @#{attribute} = val
         end 
       end
    end_eval
  eval code
end

load 'add_checked_attribute_test.rb'
