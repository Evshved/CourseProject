class CreateTagged < ActiveRecord::Migration[5.0]
  def change
    create_table :taggings do |t|
      t.belongs_to :instruction, foreign_key: true
      t.belongs_to :tag, foreign_key: true
      t.timestamps
    end
  end
end