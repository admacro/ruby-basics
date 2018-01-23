# coding: utf-8
# ruby

# repeated class defition
class Clazz
  @@version = 1.0
  def Clazz.version # class methods
    p "Version #{@@version}"
  end

  def beta
    p "Beta #{@@version}"
  end
end
Clazz.version # => "Version 1.0"
Clazz.new.beta # => "Beta 1.0"

# class method cannot be called on instances
# Clazz.new.version # undefined method `version' for #<Clazz:0x0000060029fd00> (NoMethodError)

# self in class defition
class Clazz
  @@version = 2.0
  def self.version # overrides former definition of Clazz.version
    p "#{self} V#{@@version}"
  end
end
Clazz.version # => "Clazz V 2.0"


# class variable and instance variable
class Vars
  # class variables belong to class object (Vars), which is an instance of class Class
  @@class_var = "@@class_var"
  @class_var = "@class_var"

  def initialize(inst_var)
    @inst_var = inst_var # instace variable initialized while new instance is created
  end

  def temp
    @temp_inst_var = "@temp_inst_var" # @temp_inst_var will be initialized when temp is first called
  end

  def inspect
    a = [@@class_var, @class_var, @inst_var, @temp_inst_var]
    "#{self} #{a}"
  end

  def self.inspect
    a = [@@class_var, @class_var, @inst_var, @temp_inst_var]
    "#{self} #{a}"
  end
end

v = Vars.new("instance var")

# Only class variable start with @@ are identified in instance methods
# here only @@class_var is printed but @class_var is omitted
# *TIP*: always follow naming conventions
p v # => #<Vars:0x0000060029d140> ["@@class_var", nil, "instance var", nil]

# both @@class_var and @class_var are identified in class methods
# but instance variables are dismissed
puts Vars.inspect # => Vars ["@@class_var", "@class_var", nil, nil]

# @temp_inst_var is nil until Var#temp is called
v.temp
p v # => #<Vars:0x0000060029d140> ["@@class_var", nil, "instance var", "@temp_inst_var"]

