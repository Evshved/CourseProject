class CreateImageInSteps < ActiveRecord::Migration[5.0]
  def change
    create_table :image_in_steps do |t|
      add_column :steps, :image, :string
    end
  end
end
