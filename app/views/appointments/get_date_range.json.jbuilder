if current_user&.user?
  json.array! @get_date_range
else current_doctor.present?
  json.array! @get_date_range
end
