class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.integer :type, default: 0
      t.integer :customer_id, null: false
      t.string :account_number, null: false
      t.float :current_balance, default: 0
      t.datetime :closed_at
      t.datetime :created_at
    end

    add_index :accounts, :customer_id
  end
end
