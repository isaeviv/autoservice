class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :client_name
      t.string :client_phone_number
      t.string :description
      t.timestamps
    end
  end
end
