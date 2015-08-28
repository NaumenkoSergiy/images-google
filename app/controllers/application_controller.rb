require 'picasa_images'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :client

  rescue_from Exception, with: :redirect_if_error

  def client
    @client ||= Picasa::Client.new(user_id: current_user.email, access_token: session[:token]['access_token']) if current_user
  end

  def redirect_if_error
    redirect_to root_path unless params[:controller] == 'dashboard'
  end
end
