class AddOauthToUsers < ActiveRecord::Migration
  def change
    add_column :users, :provider, :string, null: false
    add_column :users, :uid, :string, null: false
    add_column :users, :oauth_token, :string, null: false
    add_column :users, :oauth_expires_at, :datetime
  end
end
