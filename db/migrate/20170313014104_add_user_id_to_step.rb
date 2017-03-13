class AddUserIdToStep < ActiveRecord::Migration[5.0]
  def change
    add_column :steps, :user_id, :integer
  end
end
