class CreateMedicalCards < ActiveRecord::Migration[5.1]
  def change
    create_table :medical_cards do |t|
      t.string :diagnostico_user
      t.string :ciudad
      t.integer :edad
      t.float :peso
      t.float :estatura
      t.string :alergia
      t.timestamps
    end
  end
end
