class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string, null: false
    remove_column :users, :username
  end
end
