# coding: utf-8
# ruby

require_relative "rack_server"
require_relative "rack_app"

Rack::Handler::RackServer.run RackApp.new("./public")
