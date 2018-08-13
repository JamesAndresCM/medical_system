module SlotParse

  def parse_hours(start_time_hour, end_time_hour, interval_minutes)
    horas = []
    (start_time_hour.to_time.to_i..end_time_hour.to_time.to_i)
        .step(interval_minutes.to_i.minutes)
        .each do |x|
      horas << Time.at(x).strftime('%H:%M') if Time.at(x).strftime('%H:%M')
    end
    horas
  end

  def parse_date(date_slot_time, pos)
    date_slot_time.split('/')[pos].to_i
  end

  def return_range_date(start_range, end_range)
    days = []
    (start_range..end_range).select { |d| days << d if (1..5).cover?(d.wday) }
  end

  def merge_time(time_start_end)
    merge_data = []
    time_start_end.each_cons(2) { |x, y| merge_data << [x, y] }
    merge_data
  end

  def remove_hours_lunch(hours, hour_lunch, hour_lounch_more_one)
    remove_lunch_hour = []
    hours.each do |x|
      remove_lunch_hour << x if (x[0] < hour_lunch) || (x[0] >= hour_lounch_more_one)
    end
    remove_lunch_hour
  end

  def merge_final_data(range_date, lunch_data)
    merge_data = []
    range_date.each do |x|
      lunch_data.each { |y| merge_data << [x, y] }
    end
    merge_data
  end

  def json_date_time_slot(merge_data_array)
    merge_data_array.map do |j_data|
      { time_slot_date: j_data[0], start_time: j_data[1][0],
        end_time: j_data[1][1], doctor_id: current_doctor.id }
    end
  end
end