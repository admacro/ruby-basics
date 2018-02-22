# coding: utf-8
# ruby

require "uri"

PATH_SEPS = File::SEPARATOR

Content_Type_Mapping = {
  "html" => "text/html",
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


class RackApp

  def initialize(web_root)
    @web_root = web_root
  end
  
  def call(env)
    status = 200
    body = []

    puts env
    path = requested_file(env["PATH_INFO"])
    path = File.join(path, "index.html") if File.directory?(path)

    if File.exist?(path) && !File.directory?(path)
      body << IO.read(path)
      content_type = content_type(path)
    else
      status = 404
      body << "File not found\n"
      content_type = Content_Type_Mapping["txt"]
    end

    headers = response_headers(status(status), content_type, body.first.size)
    
    [status, headers, body]
  end

  def response_headers(status, content_type, content_length)
    {
      "Content-Type" => "#{content_type}",
      "Content-Length" => "#{content_length}",
      "Connction" => "close"
    }
  end

  def requested_file(path)
    clean = []
    parts = path.split(PATH_SEPS)
    
    parts.each do |part|
      next if part.empty? || part == "."
      part == ".." ? clean.pop : clean << part
    end
    
    clean.unshift PATH_SEPS if parts.empty? || parts.first.empty?
    
    File.join(@web_root, *clean)
  end

end
