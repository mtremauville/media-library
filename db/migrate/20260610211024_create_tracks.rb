class CreateTracks < ActiveRecord::Migration[8.1]
  def change
    create_table :tracks do |t|
      t.string :title
      t.integer :track_number
      t.integer :duration
      t.references :media_item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
