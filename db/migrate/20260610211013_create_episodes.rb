class CreateEpisodes < ActiveRecord::Migration[8.1]
  def change
    create_table :episodes do |t|
      t.string :title
      t.integer :season_number
      t.integer :episode_number
      t.text :synopsis
      t.integer :duration
      t.string :thumbnail_url
      t.references :media_item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
