class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients do |t|
      t.string  :first_name
      t.string  :patronymic
      t.string  :second_name
      t.string  :phone_number
      t.string  :additional_phone_number
      t.string  :email
      t.jsonb   :adress, default: {}
      t.text    :description
      
      t.timestamps
    end
  end
end
