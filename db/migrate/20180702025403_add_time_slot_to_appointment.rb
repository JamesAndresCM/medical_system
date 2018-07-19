class AddTimeSlotToAppointment < ActiveRecord::Migration[5.1]
  def change
    add_column :appointments, :time_slot_id, :integer
  end
end
