# coding: utf-8
# ruby

require "./app"

# auto reload app when a file changes
use Rack::Reloader, 0

run App.new
