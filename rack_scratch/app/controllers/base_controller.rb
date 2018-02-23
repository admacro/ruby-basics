# coding: utf-8
# ruby

class BaseController
  attr_reader :request
  
  def initialize(request)
    @request = request
  end

  def index
    # <<~ is called the squiggly heredoc (since Ruby v2.3).
    # Unlike <<-, it strips the leading whitespace.
    # Tip: ~ is called tilde in English.
    build_response <<~HTML
      <html>
        <head><title>A Rack Demo</title></head>
        <body>
          <h1>This is the root page</h1>
          <p>Hello from Base controller!</p>
        </body>
      </html>
    HTML
  end

  private
  
  def build_response(body, status: 200)
    [status, {"Content-Type" => "text/html"}, [body]]
  end

  def redirect_to(uri)
    [302, {"Location" => uri}, []]
  end

  def params
    @request.params
  end
end
