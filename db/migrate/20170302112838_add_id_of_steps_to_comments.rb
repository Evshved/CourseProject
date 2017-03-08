class AddIdOfStepsToComments < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :step_id, :integer
  end
end
