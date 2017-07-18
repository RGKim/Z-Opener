class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.string :template_name
      t.string :type
      t.date :created_date
      t.string :account

      t.timestamps
    end
  end
end
