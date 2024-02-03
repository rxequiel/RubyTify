class Api::V1::AlbumsController < ApplicationController
    def index
        artist = Artist.find(params[:artist_id])
        albums = artist.albums
        render json: { data: albums }
      end
end
