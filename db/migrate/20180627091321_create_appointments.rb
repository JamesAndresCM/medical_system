class CreateAppointments < ActiveRecord::Migration[5.1]
  def change
    create_table :appointments do |t|
      t.date :appointment_date
      t.integer :user_id
      t.integer :doctor_id
      t.timestamps
    end
  end
end
