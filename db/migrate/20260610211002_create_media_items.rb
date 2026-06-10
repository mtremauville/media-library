class CreateMediaItems < ActiveRecord::Migration[8.1]
  def change
    create_table :media_items do |t|
      t.string :title
      t.string :media_type
      t.string :external_id
      t.string :poster_url
      t.text :synopsis
      t.decimal :rating
      t.date :release_date
      t.references :user, null: false, foreign_key: true
      t.jsonb :metadata

      t.timestamps
    end
  end
end
