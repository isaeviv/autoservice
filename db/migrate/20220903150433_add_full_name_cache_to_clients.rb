class AddFullNameCacheToClients < ActiveRecord::Migration[7.0]
  def change
    add_column :clients, :full_name_cache, :string
    Client.find_each do |client|
      client.update_columns(full_name_cache: client.set_full_name_cache)
    end
  end
end
