class PhotosController < ApplicationController
  before_filter :check_authorization_code

  def destroy
    begin
      client.photo.destroy(params[:album_id], params[:id])
    rescue => e
      flash[:error] = e.message
    end
    redirect_to root_path
  end

  def new; end

  def create
    begin
      photo_bin = File.binread(params[:file].tempfile)
      albums = client.album.list.entries

      client.photo.create(params[:album_id],
        {
          binary: photo_bin,
          content_type: "image/jpeg",
          title: params[:file].original_filename
        }
      )
    rescue => e
      flash[:error] = e.message
    end

    redirect_to root_path
  end

  private

  def check_authorization_code
    redirect_to code_authorization_url if session[:code].nil?
  end
end
