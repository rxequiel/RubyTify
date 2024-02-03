class Api::V1::GenresController < ApplicationController
    def random_song
        genre_name = params[:genre_name]
        songs = Song.joins(album: { artist: :genres }).where('genres.name LIKE ?', "%#{genre_name}%").order('RANDOM()').limit(1)
        render json: { data: songs }
      end
end
