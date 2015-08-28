require 'picasa_images'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :client

  def client
    @client ||= Picasa::Client.new(user_id: current_user.email, access_token: session[:token]['access_token']) if current_user
  end
end
