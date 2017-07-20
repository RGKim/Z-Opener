class AddToFieldsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :ibm_id, :string
    add_column :users, :ibm_key, :string
  end
end
