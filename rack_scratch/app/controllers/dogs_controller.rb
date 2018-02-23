# coding: utf-8
# ruby

require_relative "base_controller"

class DogsController < BaseController

  # GET /dogs
  def index
    build_response dog_page("we should have a list of dogs here")
  end

  # GET /dogs/:id
  def show
    build_response dog_page("this should show dog ##{params[:id]}")
  end

  # GET /dogs/new
  def new
    build_response dog_page("a page to create a new dog")
  end

  # POST /dogs
  #
  # When using WEBrick as the server, POST request with empty
  # body causes an error (curl -X POST -I localhost:9292/dogs)
  #   ERROR WEBrick::HTTPStatus::LengthRequired
  # Switching to a different server, for example puma or thin, will work.
  # Ref: https://github.com/rack/rack/wiki/(tutorial)-rackup-howto
  def create
    redirect_to "/dogs"
  end

  private

  def dog_page(message)
    <<~HTML
      <html>
        <head><title>A Rack Demo</title></head>
        <body>
          <h1>This is DogsController##{params[:action]}</h1>
          <p>#{message}</p>
        </body>
      </html>
    HTML
  end
end
