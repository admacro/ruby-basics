# coding: utf-8
# ruby

require_relative "base_controller"
require "ostruct"

class DogsController < BaseController

  # GET /dogs
  def index
    @title = "So many dogs"
    @dogs = (1..5).map do |i|
      OpenStruct.new(id: i, name: "Dog-#{i}")
    end
    build_response render_template
  end

  # GET /dogs/:id?name=optional_custom_name
  def show
    id = params[:id]
    dog_name = params["name"] || "Dog-#{id}"
    @title = "#{dog_name}'s page"
    @dog = OpenStruct.new(id: id, name: dog_name)
    build_response render_template
  end

  # GET /dogs/new
  def new
    @title = "More dogs please"
    build_response render_template
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

end
