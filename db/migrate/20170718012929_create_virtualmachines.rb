class CreateVirtualmachines < ActiveRecord::Migration[5.1]
  def change
    create_table :virtualmachines do |t|
      t.string :datacenter
      t.string :price
      t.text :description

      t.timestamps
    end
  end
end
