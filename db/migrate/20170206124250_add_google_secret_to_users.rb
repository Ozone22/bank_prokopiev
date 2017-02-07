class AddGoogleSecretToUsers < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :google_secret, :string
  end
end
