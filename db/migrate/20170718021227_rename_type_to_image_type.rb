class RenameTypeToImageType < ActiveRecord::Migration[5.1]
  def change
    rename_column :images, :type, :image_type
  end
end
