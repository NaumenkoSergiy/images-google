class DashboardController < ApplicationController
  def index
    @albums = client.album.list.albums if current_user
  end
end
