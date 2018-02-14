# coding: utf-8
# ruby

require "socket"

CRLF = "\r\n"
server = TCPServer.new "localhost", 1225

loop do
  socket = server.accept

  request = socket.gets

  puts request
  STDERR.puts request

  response_body = "Hello World!\n"
  response_status_line = "HTTP/1.1 200 OK" + CRLF
  response_content_type = "Content-Type: text/plain" + CRLF
  response_content_length = "Content-Length: #{response_body.bytesize}" + CRLF
  response_connection = "Connection: close" + CRLF

  response = response_status_line +
             response_content_type +
             response_content_length +
             response_connection +
             CRLF +
             response_body
  
  socket.print response

  socket.close
end
