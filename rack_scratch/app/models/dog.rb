# coding: utf-8
# ruby

require_relative "base"

class Dog < Base
  attr_accessor :id, :name

  def initialize(id: nil, name: nil)
    @id = id
    @name = name
  end
end
