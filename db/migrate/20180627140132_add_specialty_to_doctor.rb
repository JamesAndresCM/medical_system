class AddSpecialtyToDoctor < ActiveRecord::Migration[5.1]
  def change
    add_column :doctors, :specialty_id , :integer
  end
end
