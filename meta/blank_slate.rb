# coding: utf-8
# ruby

# blank slate (p231, 66)
#   used to remove common methods from an object.
#
# background and explaination
#
# Since every class inherits from Object inplicitly, it also gets all the
# methods of Object by default. When you use method_missing spell to enpower
# your API users to create their own methods, it's possible they run into
# situations where the method name collide with those in Object. Therefore, 
# to give your users a clean place/room to wield their creativity, you can
# make your class inherit BasicObject explicitly.

class Layman
  def method_missing(name, *args)
    'A zombie method (not very ghosty)'
  end
end

class Artist < BasicObject
  def method_missing(name, *args)
    'A ghost method (almost ghosty)'
  end
end

puts Layman.new.to_s # => #<Layman:0x007fa3268127b8>
puts Artist.new.to_s # => A ghost method (almost ghosty)
