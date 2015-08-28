require 'picasa_images'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :client, :code_authorization_url

  def client
    @client ||= Picasa::Client.new(user_id: current_user.email, access_token: session[:token]['access_token']) if current_user
  end

  def code_authorization_url
    "https://accounts.google.com/o/oauth2/auth?scope=http://picasaweb.google.com/data/&redirect_uri=#{ENV['AUTH_REDIRECT_URL']}/&response_type=code&client_id=#{ENV['GOOGLE_CLIENT_ID']}"
  end
end
