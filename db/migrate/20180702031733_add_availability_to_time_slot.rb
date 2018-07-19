class AddAvailabilityToTimeSlot < ActiveRecord::Migration[5.1]
  def change
    add_column :time_slots, :availability, :boolean, default: true
  end
end
