class AddTwoStepAuthToUser < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :two_step_auth, :boolean, null: false, default: false
  end
end
