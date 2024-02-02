class CreateArtists < ActiveRecord::Migration[7.1]
  def change
    create_table :artists do |t|
      t.string :name
      t.string :image
      t.string :genres
      t.integer :popularity
      t.string :spotify_url
      t.string :spotify_id

      t.timestamps
    end
  end
end
