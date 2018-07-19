class AddLastNameMotherToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :last_name_mother, :string
  end
end
