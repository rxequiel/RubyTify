#agregamos gemas necesarias
require 'rspotify'
require 'yaml'

#autenticamos en espotify
#RSpotify.authenticate(ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_CLIENT_SECRET'])

#iniciamos un espacio de trabajo 

namespace :import do
    desc "tomara un archivo .yml lo importara, y tomara su contenido como un listado para extraer info de spotify"
    task :data => :environment do
        puts "IMPORTANDO ARCHIVO YAML"
        artist_list=YAML.load_file('E:\Aplication\RubyTify\artists.yml')

        puts "EXTRAYENDO INFO ARTISTS"
        artist_list["artists"].each do |artist_name| #listamos
            artist=RSpotify::Artist.search(artist_name.to_s).first
            Artist.create!( #creamos las nuevas entradas del modelo artista
                name: artist.name,
                image: artist.images.first['url'],
                genres: artist.genres.join[','],
                popularity: artist.popularity,
                spotify_url: artist.external_urls['spotify'],
                spotify_id: artist.id
            )

            puts "EXTRAYENDO INFO DE ALBUMS"
            artist.albums.each do |album|
                Album.create!(
                    name: album.name,
                    image: album.images.first&.fetch('url',nil),
                    spotify_url: album.external_urls['spotify'],
                    total_tracks: album.total_tracks,
                    spotify_id: album.id,
                    artist: Artist.find_by(spotify_id: artist.id)
                )
            
                album.tracks.each do |track|
                    Song.create!(
                        name: track.name,
                        spotify_url: track.external_urls['spotify'],
                        preview_url: track.preview_url,
                        duration_ms: track.duration_ms,
                        explicit: track.explicit,
                        spotify_id: track.id,
                        album: Album.find_by(spotify_id: album.id)
                    )
                end #FIN DE SONGS
            end #fin almbun
        end #fin artist_list
        
        puts "EXTRACCION EXITOSA"


    end #fin de la tarea
end #fin spacio