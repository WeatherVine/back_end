class WineWeatherSerializer
  include FastJsonapi::ObjectSerializer
  set_id nil
  set_type 'w'

  attributes :api_id,
    :name,
    :area,
    :vintage,
    :eye,
    :nose,
    :mouth,
    :finish,
    :overall,
    :temp,
    :precip,
    :start_date,
    :end_date
end
