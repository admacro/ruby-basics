# coding: utf-8
# ruby

# spells used:
#   flat scope
#   shared scope
#   deferred evaluation (passing Proc objects)
#   clean room

lambda {
  setups = []

  Kernel.send :define_method, :setup, ->(&block) { setups << block }

  # Lambdas don't implicitly accept blocks like regular methods do, so can't yield.
  # the following will not work, you need to add it in to the argument list.
  #   => no block given (yield) (LocalJumpError)
  #
  #   event = ->(description) {
  #     setups.each { |setup| setup.call }
  #     puts "ALERT: #{description}" if yield
  #   }
  #

  event = ->(description, &block) {
    # evalutaion of setup and event must be in the same object as event need to
    # access instance variables in setup.
    #
    # Error if evaluation object is not the same one
    #   => undefined method `<' for nil:NilClass (NoMethodError)
    #
    env = Object.new
    setups.each { |setup| env.instance_eval &setup }
    puts "ALERT: #{description}" if env.instance_eval &block
  }
  
  Kernel.send :define_method, :event, event
}.call

load 'events.rb'
