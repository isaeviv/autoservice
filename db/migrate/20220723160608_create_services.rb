class CreateServices < ActiveRecord::Migration[6.1]
  def change
    create_table :services do |t|
      t.string  :name
      t.integer :order_id
      t.integer :price
      t.timestamps
    end
  end
end
