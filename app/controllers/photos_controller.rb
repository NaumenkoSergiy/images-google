class PhotosController < ApplicationController
  def destroy
    if session[:code]
      client.photo.destroy(params[:album_id], params[:id])
      redirect_to root_path
    else
      redirect_to "https://accounts.google.com/o/oauth2/auth?scope=http://picasaweb.google.com/data/&redirect_uri=http://localhost:3000/authorization_code&response_type=code&client_id=#{ENV['GOOGLE_CLIENT_ID']}"
    end
  end
end
