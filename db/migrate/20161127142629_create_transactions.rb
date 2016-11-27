class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.integer :sender_account_id, null: false
      t.integer :recipient_account_id, null: false
      t.float :amount, default: 0
      t.timestamps
    end

    add_index :transactions, :sender_account_id
    add_index :transactions, :recipient_account_id
  end
end
