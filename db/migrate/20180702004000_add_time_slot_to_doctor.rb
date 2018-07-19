class AddTimeSlotToDoctor < ActiveRecord::Migration[5.1]
  def change
    add_column :time_slots, :doctor_id, :integer
  end
end
