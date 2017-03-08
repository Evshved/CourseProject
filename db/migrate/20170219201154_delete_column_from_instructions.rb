class DeleteColumnFromInstructions < ActiveRecord::Migration[5.0]
  def change
    remove_column :instructions, :string
  end
end
