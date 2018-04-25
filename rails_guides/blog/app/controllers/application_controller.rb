class ApplicationController < ActionController::Base
  # :with => set the method for handling the unverified request
  # :exception => Raises ActionController::InvalidAuthenticityToken exception.
  #
  # See api details at
  #   http://api.rubyonrails.org/classes/ActionController/RequestForgeryProtection/ClassMethods.html
  protect_from_forgery with: :exception
end
