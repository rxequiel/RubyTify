class Artist < ApplicationRecord
    has_many :albums , dependent: :destroy
    has_many :songs , through: :album
    #validates_presence_of :name, :image, :genres, :popularity, :spotify_url, :spotify_id
end
