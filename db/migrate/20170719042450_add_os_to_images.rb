class AddOsToImages < ActiveRecord::Migration[5.1]
  def change
    add_column :images, :os, :string
  end
end
