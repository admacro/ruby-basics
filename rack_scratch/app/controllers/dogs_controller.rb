# coding: utf-8
# ruby

require_relative "base_controller"
require "ostruct"

class DogsController < BaseController

  # GET /dogs
  def index
    @title = "So many dogs"
    @dogs = Dog.all
    build_response render_template
  end

  # GET /dogs/:id
  def show
    @dog = Dog.find(params[:id])
    @title = "#{@dog}'s page"
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
    dog = Dog.new(name: params['dog']['name'])
    dog.save
    redirect_to "/dogs/#{dog.id}"
  end

end
