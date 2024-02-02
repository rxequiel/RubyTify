class Album < ApplicationRecord
  belongs_to :artist
  has_many :songs , dependent: :destroy
  #validates_presence_of :name, :spotify_url, :total_tracks, :spotify_id, :artist_id
end
