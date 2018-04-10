# coding: utf-8
# ruby

# spells used:
#   flat scope
#   shared scope
#   deferred evaluation (passing Proc objects)

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
    setups.each { |setup| setup.call }
    Kernel.puts "ALERT: #{description}" if block.call
  }
  
  Kernel.send :define_method, :event, event
}.call

load 'events.rb'
