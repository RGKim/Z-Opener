class AddMonitoringToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :monitoring, :integer
  end
end
