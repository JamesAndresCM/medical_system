class CreatePrescriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :prescriptions do |t|
      t.integer :doctor_id
      t.integer :user_id
      t.string :descripcion
      t.timestamps
    end
  end
end
