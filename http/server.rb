# coding: utf-8
# ruby

require "socket"
require "uri"

PATH_SEPS = File::SEPARATOR
CRLF = "\r\n"
Web_Root = "./public"

Content_Type_Mapping = {
  "html" => "text/html",

  # Without charset=utf-8, browser will not display
  # unicode characters correctly
  "txt" => "text/plain; charset=utf-8",
  
  "jpg" => "image/jpeg",
  "png" => "image/png"
}
Content_Type_Mapping.default = "application/octet-stream"

Status_Desc_Mapping = {
  200 => "OK",
  404 => "Not Found"
}

def status(code)
  "#{code} #{Status_Desc_Mapping[code]}"
end

def content_type(path)
  ext = File.extname(path).split('.').last
  Content_Type_Mapping[ext]
end

def response_header(status, content_type, content_length)
  # CRLF is required at the end of every header line, as per Http protocol
  response_status_line = "HTTP/1.1 #{status}" + CRLF
  response_content_type = "Content-Type: #{content_type}" + CRLF
  response_content_length = "Content-Length: #{content_length}" + CRLF
  response_connection = "Connection: close" + CRLF

  # plus(+) must be at the end of a line, not the beginning
  response_header = response_status_line + 
                    response_content_type +
                    response_content_length +
                    response_connection +
                    CRLF # required by Http protocol for separating header and body
end

def requested_file(request_line)
  uri = request_line.split(" ")[1]

  # Decode URL-encoded form data
  # a=1&b=%24abc => [["a", "1"], ["b", "$abc"]] # %24 is ASCII code of $
  # URI.decode_www_form can be replaced by CGI.unescape
  path = URI.decode_www_form(URI(uri).path).first.first

  # Today's browsers and curl remove ".." from the URI
  # before sending the request to the server, so we're
  # safe as to the handling of request URI here.
  # However, we can still try to implement the sanitizing
  # logic here to understand more about the security issue.
  #
  # We will remove empty, current directory (.) and
  # process parent directory (..) accroding to Rack::Utils
  clean = []
  parts = path.split(PATH_SEPS)
  parts.each do |part|
    next if part.empty? || part == "."
    
    # remove last added clean part if the following part is ..
    # E.g. "/cgi/../cgi/test" => "/cgi/test"
    part == ".." ? clean.pop : clean << part
  end

  clean.unshift PATH_SEPS if parts.empty? || parts.first.empty?

  # File.join(string, ...) => join the strings with "/"
  File.join(Web_Root, *clean)
end

def start
  server = TCPServer.new "localhost", 1225

  loop do

    # waiting for incoming requests
    socket = server.accept

    # get the first line of request
    request_line = socket.gets

    puts request_line
    path = requested_file(request_line)
    path = File.join(path, "index.html") if File.directory?(path)
    puts path

    if File.exist?(path) && !File.directory?(path)
      File.open(path, "rb") do |file|        
        socket.print response_header(status(200), content_type(path), file.size)
        IO.copy_stream(file, socket)
      end
    else
      message = "File not found\n"
      socket.print response_header(status(404), Content_Type_Mapping["txt"], message.size)
      socket.print message
    end

    socket.close
  end
end

def test
  p status(200)
  p content_type("/pictures/dog.png")
  p content_type("/script.sh")
  p requested_file("GET /index.html HTTP/1.1")
  puts response_header(status(404), content_type("/test.html"), 100)
end

test

start
