class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
	  t.string :email,				null: false
	  t.string :first_name, 		null: false
	  t.string :last_name,			null: false
	  t.string :middle_name
	  t.string :phone,				null: false
	  t.string :password_digest,	null: false
      t.timestamps					null: false
    end

    add_index :users, :phone, unique: true
    add_index :users, :email, unique: true
  end
end
