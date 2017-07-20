class AddProvisionScriptToImages < ActiveRecord::Migration[5.1]
  def change
    add_column :images, :provision_script, :string
  end
end
