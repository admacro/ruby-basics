# coding: utf-8
# ruby

class Roulette
  def method_missing(name, *args)
    person = name.to_s.capitalize

    # removing this line will cause infinite loop
    # => stack level too deep (SystemStackError)
    number = 0 
    3.times do
      number = rand(10) + 1
      puts "#{number}..."
    end

    # all variables in method_missing block should be declared,
    # if not Ruby treats it as a method name and tries to invoke
    # it which if does not exist causes infinite call to method_missing
    "#{person} got a #{number}"
  end
end

number_of = Roulette.new
puts number_of.james
puts number_of.russell
