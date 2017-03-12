class AddIdOfStepToPhoto < ActiveRecord::Migration[5.0]
  def change
    add_column :photos, :has_connection, :boolean
  end
end
