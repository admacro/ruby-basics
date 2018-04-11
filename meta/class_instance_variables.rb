# coding: utf-8
# ruby

# class instance variables and class variables (p110)
#
# run this script to see the difference between
# `class instance variables` (@v) and `class variables` (@@v)
#
# tldr;
# Class variables don't belong to class, they belong to class hierarchies.
# Here, @@v is defined in the context of main and it belongs to two hierarchies:
#   1) Object > Temp
#   2) Object > Temp2
# So changing @@v in any of top level, Temp or Temp2 will be reflected in all.
#
# Practically, due to the above effect of class variables, for safty's sake,
# it's better to use class instance variables as they have the same effect as
# class variables in most cases. (what are the cases we must use one or the other?)

@@v = 0
@v = 0

p "@@v in top level => #{@@v}"
p "@v in top level => #{@v}"


class Temp
  @@v = 1
  @@c = 1
  @v = 1

  def self.class_v; @@v end
  def self.class_c; @@c end
  def self.class_instance_v; @v end
  
  p "@@v in Temp => #{@@v}"
  p "@@c in Temp => #{@@c}"
  p "@v in Temp => #{@v}"
end

def test
  p "@@v in top level => #{@@v}"
  p "@v in top level => #{@v}"

  p "@@v of Temp in topl level => #{Temp.class_v}"
  p "@@c of Temp in topl level => #{Temp.class_c}"
  p "@v of Temp in topl level => #{Temp.class_instance_v}"
end

test

class Temp2
  @@v = 2
  @@c = 2
  @v = 2

  p "@@v in Temp2 => #{@@v}"
  p "@@c in Temp => #{@@c}"
  p "@v in Temp2 => #{@v}"
end

test
