class AddClientIdToOrdersAndServices < ActiveRecord::Migration[7.0]
  def change
    add_column  :services, :client_id, :integer
    add_column  :orders, :client_id, :integer
  end
end
