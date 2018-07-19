class TimeSlotController < ApplicationController
  load_and_authorize_resource
  before_action :time_slot_params, only: %i[create]
  before_action :set_time_slot, only: %i[destroy]
  before_action :respond_to_html, only: %i[show destroy]

  def index
    @time_slot = current_doctor.time_slots.where(availability: true).ordenados
  end

  def show; end

  def new
    @time_slot = TimeSlot.new
  end

  def create
    # recibo parametros TODO: validates fields
    start_time = params[:time_slot][:start_time]
    end_time = params[:time_slot][:end_time]
    work_interval = params[:time_slot][:work_interval]
    lunch_hour = params[:time_slot][:lunch_hour]
    date_slot = params[:time_slot][:time_slot_date]

    # al parametro de hora almuerzo se le agregan 120 minutos
    # example : horaalmuerzo = 13:00 <--hora final--> 15:00
    lunch_more_one_hour = (Time.parse(lunch_hour) + 120.minutes).strftime('%H:%M')

    # se establecen las horas de trabajo de acuerdo a los intervalos
    # example : if interval == 20 minutos y se decide hora inicio 9 y termino 16 9:00->09:20...
    interval_hours_final = parse_hours(start_time, end_time, work_interval)

    # se asignan rangos de horas a array ["10:00", "10:20"]
    in_data = merge_time(interval_hours_final)

    # se remueve horas almuerzo
    remove_lunch_hour = remove_hours_lunch(in_data, lunch_hour,
                                           lunch_more_one_hour)

    # se parsea dato inicio y fin(fechas) recibe 09/07/2018 - 13/07/2018
    # se requiere 2018,07,09
    start_date = date_slot.to_s.split('-')[0].strip
    end_date = date_slot.to_s.split('-')[1].strip

    start_date_final = Date.new(parse_date(start_date, 2),
                                parse_date(start_date, 1),
                                parse_date(start_date, 0))

    end_date_final = Date.new(parse_date(end_date, 2), parse_date(end_date, 1),
                              parse_date(end_date, 0))

    # rangos finales de fecha
    range_date_final = return_range_date(start_date_final, end_date_final)

    # se construye array final fechas , start_time y end_time
    # example : [ "2018-07-09", [ "10:00", "10:20"]]
    merge_data = merge_final_data(range_date_final, remove_lunch_hour)

    # array se pasa a hash para enviar a bd
    result = json_date_time_slot(merge_data)
    # render json: result

    @time_slot = TimeSlot.create(result)

    respond_to do |format|
      format.html {
        redirect_to doctor_time_slot_index_path(current_doctor),
                    notice: 'El horario ha sido creado correctamente.'
      }
    end
  end

  def destroy
    @time_slot.destroy
    respond_to do |format|
      format.js {}
    end
  end

  private

  def time_slot_params
    params.require(:time_slot).permit(:start_time, :end_time, :doctor_id,
                                      :time_slot_date, :lunch_hour,
                                      :work_interval)
  end

  def set_time_slot
    @time_slot = TimeSlot.find(params[:id])
  end

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

  def respond_to_html
    respond_to do |format|
      format.html {
        redirect_to doctor_time_slot_index_path(current_doctor),
                    notice: 'error pagina no encontrada'
      }
      format.js {}
    end
  end
end
