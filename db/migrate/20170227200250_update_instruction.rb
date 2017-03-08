class UpdateInstruction < ActiveRecord::Migration[5.0]
  def change
    remove_column :instructions, :body
    add_column :instructions, :category, :string
    add_column :instructions, :youtube_link, :string
  end
end
