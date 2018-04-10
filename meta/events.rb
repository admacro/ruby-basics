# coding: utf-8
# ruby

# Expected output:
#   Setting up sky
#   Setting up mountains
#   ALERT: the sky is falling
#   Setting up sky
#   Setting up mountains
#   ALERT: it's getting closer
#   Setting up sky
#   Setting up mountains

setup do
  puts "Setting up sky"
  @sky_height = 100
end

setup do
  puts "Setting up mountains"
  @mountains_height = 200
end

event "the sky is falling" do
  @sky_height < 300
end

event "it's getting closer" do
  @sky_height < @mountains_height
end

event "whoops... too late" do
  @x = 1
  @sky_height < 0
end

event "mountain is sinking..." do
  puts @x
  true
end
