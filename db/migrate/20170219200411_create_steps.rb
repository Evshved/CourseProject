class CreateSteps < ActiveRecord::Migration[5.0]
  def change
    create_table :steps do |t|
      t.string 'img'
      t.string 'description'
      t.integer 'order'
      t.integer 'instruction_id', null: false
      t.timestamps
    end
  end
end
