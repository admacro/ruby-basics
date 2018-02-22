# coding: utf-8
# ruby

require "socket"
require "stringio"
require "rack"
require_relative "rack_app"

CRLF = "\r\n"

class RackServer
  attr_accessor :host, :port

  def initialize(app)
    @app = app
    @host = "localhost"
    @port = 1225
  end
  
  def start
    server = TCPServer.new host, port

    loop do

      # waiting for incoming requests
      socket = server.accept

      # get the first line of request
      request_line = socket.gets

      env = env(request_line)
      status, headers, body = @app.call(env)

      response = "HTTP/1.1 #{status}" + CRLF
      
      if headers.respond_to? "each"
        headers.each { |key, value| response << "#{key}: #{value}" + CRLF }
        response << CRLF
      else
        raise "Response headers must be a Hash object. headers => #{headers}"
      end
      
      if body.respond_to? "each"
        body.each { |chunk| response << chunk }
      else
        raise "Response body must respond to each. body => #{body}"
      end

      socket.print response
      
      socket.close
    end
  end

  def env(request_line)
    method, uri, protocol = request_line.split(' ')
    u = URI(uri)
    {
      "REQUEST_METHOD" => method,
      "SCRIPT_NAME" => "",
      "PATH_INFO" => u.path,
      "QUERY_STRING" => u.query,
      "SERVER_NAME" => @host,
      "SERVER_PORT" => @port,
      
      # The Rack protocol version number implemented. (Not the RELEASE version number)
      "rack.version" => Rack::VERSION, 

      "rack.url_scheme" => "http",
      "rack.input" => StringIO.new,
      "rack.errors" => StringIO.new,
      "rack.multithread" => false,
      "rack.multiprocess" => false,
      "rack.run_once" => false,
      "rack.hijack?" => false,
      "rack.hijack" => nil,
      "rack.hijack_io" => nil
    }
  end

end

module Rack
  module Handler
    class RackServer
      def self.run(app, options = {})
        server = ::RackServer.new(app)
        server.start
      end
    end
  end
end

Rack::Handler.register("rack_server", "Rack::Handler::RackServer")
