# coding: utf-8
# ruby

# spells used:
#   flat scope
#   deferred evaluation (passing Proc objects)

@setups = []

def setup(&block)
  @setups << block
end

def event(description)
  @setups.each { |setup| setup.call }
  puts "ALERT: #{description}" if yield
end

load 'events.rb'
