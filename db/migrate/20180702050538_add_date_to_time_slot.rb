class AddDateToTimeSlot < ActiveRecord::Migration[5.1]
  def change
    add_column :time_slots, :time_slot_date, :date
  end
end
