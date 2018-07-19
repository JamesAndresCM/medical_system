class TimeSlot < ApplicationRecord
  belongs_to :doctor
  has_many :appointments, dependent: :destroy

  attr_accessor :lunch_hour
  attr_accessor :work_interval
  enum hora: %i[09:00 10:00 11:00 12:00 13:00 14:00 15:00 16:00 17:00 18:00 19:00]
  #enum interval: (5..60).step(5).to_a
  enum interval: %i[10 20 30 40 50 60]

  validates_presence_of :start_time
  validates_presence_of :end_time
  #validates_presence_of :doctor_id, numericality: true
  validates_numericality_of :doctor_id
  validates_presence_of :time_slot_date
  scope :ordenados, -> {order('created_at DESC')}
end
