# coding: utf-8
# ruby

# random number
# use an entropy source provided by OS as a random(ish) seed
# the series of numbers are different each time the program is run
3.times do
  p rand
end

p "use constant seed"
# the series of numbers are the same each time the program is run
srand 23 # set a constant seed (before calling rand)
3.times do
  p rand
end


# 
