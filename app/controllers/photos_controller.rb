class PhotosController < ApplicationController
  before_filter :check_authorization_code

  def destroy
    client.photo.destroy(params[:album_id], params[:id])
    redirect_to root_path
    redirect_to "https://accounts.google.com/o/oauth2/auth?scope=http://picasaweb.google.com/data/&redirect_uri=http://localhost:3000/authorization_code&response_type=code&client_id=#{ENV['GOOGLE_CLIENT_ID']}"
  end

  def new; end

  def create
    photo_bin = File.binread(params[:file].tempfile)
    albums = client.album.list.entries
    album = albums.find { |album| album.id == params[:album_id] }

    client.photo.create(album.id,
      {
        binary: photo_bin,
        content_type: "image/jpeg",
        title: params[:file].original_filename
      }
    )

    redirect_to root_path
  end

  private

  def check_authorization_code
    redirect_to "https://accounts.google.com/o/oauth2/auth?scope=http://picasaweb.google.com/data/&redirect_uri=http://localhost:3000/authorization_code&response_type=code&client_id=#{ENV['GOOGLE_CLIENT_ID']}" if session[:code].nil?
  end
end
