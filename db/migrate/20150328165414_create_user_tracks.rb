class CreateUserTracks < ActiveRecord::Migration
  def change
    create_table :user_tracks do |t|
      t.references :user
      t.references :track

      t.timestamps null: false
    end
  end
end
