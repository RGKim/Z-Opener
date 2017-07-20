class RemoveOsFromOrders < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :os, :string
  end
end
