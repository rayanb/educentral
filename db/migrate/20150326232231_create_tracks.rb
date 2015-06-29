class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :name, null: false
      t.references :user, null: false
      t.references :category, null: false
      t.integer :popularity, default: 1
      t.integer :parent_id

      t.timestamps null: false
    end
  end
end
