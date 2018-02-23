# coding: utf-8
# ruby

require "rack"

app = Proc.new do |env|
  ['200', {'Content-Type' => 'text/html'}, ['Hello Rack!']]
end

p Rack::VERSION

Rack::Handler::WEBrick.run app
