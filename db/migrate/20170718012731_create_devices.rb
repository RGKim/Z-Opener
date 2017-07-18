class CreateDevices < ActiveRecord::Migration[5.1]
  def change
    create_table :devices do |t|
      t.string :domain
      t.string :type
      t.string :public_ip
      t.string :private_ip
      t.string :region
      t.string :state
      t.date :order_date

      t.timestamps
    end
  end
end
