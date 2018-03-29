require 'test_helper'

class TricycleTest < ActiveSupport::TestCase

  test "should save" do
    bao_10_jie = Tricycle.create(color:"blue", price: 300)
    assert_not_nil bao_10_jie
    # puts bao_10_jie.inspect
  end
  
end
