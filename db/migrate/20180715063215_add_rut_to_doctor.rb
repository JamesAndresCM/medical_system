class AddRutToDoctor < ActiveRecord::Migration[5.1]
  def change
    add_column :doctors, :rut, :string, unique: true
  end
end
