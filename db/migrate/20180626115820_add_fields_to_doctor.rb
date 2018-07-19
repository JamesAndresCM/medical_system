class AddFieldsToDoctor < ActiveRecord::Migration[5.1]
  def change
    add_column :doctors, :last_name_mother, :string
    add_column :doctors, :last_name, :string
    add_column :doctors, :phone_number, :integer
    add_column :doctors, :username, :string
  end
end
