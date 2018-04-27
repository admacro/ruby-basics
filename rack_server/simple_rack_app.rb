# coding: utf-8
# ruby

require "rack"

# To use Rack, provide an "app": an object that responds to the call method,
# taking the environment hash as a parameter, and returning an Array with
# three elements:
# 
#   - The HTTP response code
#   - A Hash of headers
#   - The response body, which must respond to each

# The reason you can pass a Proc object to run is Proc responds to call.
# Check Ruby doc for details.
app = Proc.new do |env|
  ['200', {'Content-Type' => 'text/html'}, ['Hello Rack!']]
end

p Rack::VERSION

Rack::Handler::WEBrick.run app
