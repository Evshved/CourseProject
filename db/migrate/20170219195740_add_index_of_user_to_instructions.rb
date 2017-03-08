class AddIndexOfUserToInstructions < ActiveRecord::Migration[5.0]
  def change
    add_column :instructions, :user_id, :integer
  end
end
