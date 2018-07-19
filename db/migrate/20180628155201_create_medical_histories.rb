class CreateMedicalHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :medical_histories do |t|
      t.text :body
      t.integer :medical_card_id
      t.integer :doctor_id
      t.timestamps
    end
  end
end
