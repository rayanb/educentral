class AddOrderToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :order, :string
  end
end
