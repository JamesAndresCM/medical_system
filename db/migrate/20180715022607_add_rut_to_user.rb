class AddRutToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :rut, :string, unique: true
  end
end
