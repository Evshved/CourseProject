class DeleteImgFromStep < ActiveRecord::Migration[5.0]
  def change
    remove_column :steps, :img
  end
end
