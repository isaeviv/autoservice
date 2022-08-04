class AddPriceToOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :price, :integer, default: 0
  end
end
