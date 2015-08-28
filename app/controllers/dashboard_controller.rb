class DashboardController < ApplicationController
  def index
    @albums = client.album.list.albums
  end
end
