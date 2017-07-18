class AddTemplateIdToImages < ActiveRecord::Migration[5.1]
  def change
    add_column :images, :templateid, :string
  end
end
