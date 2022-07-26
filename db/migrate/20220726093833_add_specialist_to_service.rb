class AddSpecialistToService < ActiveRecord::Migration[6.1]
  def change
    add_column :services, :specialist_id, :integer
  end
end
