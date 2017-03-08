class CreateInstructions < ActiveRecord::Migration[5.0]
  def change
    create_table :instructions do |t|
      t.string :title, :string
      t.string :body,  :string
      t.timestamps
    end
  end
end
