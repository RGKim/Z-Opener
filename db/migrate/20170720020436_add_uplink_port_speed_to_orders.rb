class AddUplinkPortSpeedToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :uplink_port_speed, :integer
  end
end
