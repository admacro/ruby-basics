# coding: utf-8
# ruby

require 'test/unit'
require_relative 'using'

class TestUsing < Test::Unit::TestCase
  class Resource
    def dispose
      @disposed = true
    end

    def disposed?
      @disposed
    end

    def read
      'Hello'
    end
  end
  
  def test_disposes_of_resources
    r = Resource.new
    using(r) { puts r.read }
    assert r.disposed?
  end

  def test_disposes_of_resources_in_case_of_exception
    r = Resource.new
    assert_raises(Exception) {
      using(r) {
        raise Exception
      }
    }
    assert r.disposed?
  end
end
