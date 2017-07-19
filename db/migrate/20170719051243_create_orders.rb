class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :hostname
      t.string :domain
      t.integer :location
      t.string :os
      t.boolean :usehourlypricing
      t.integer :cpu
      t.integer :ram
      t.integer :first_disk
      t.integer :second_disk
      t.string :bandwidth
      t.references :image, foreign_key: true

      t.timestamps
    end
  end
end
