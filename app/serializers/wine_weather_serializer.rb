class WineWeatherSerializer
  include FastJsonapi::ObjectSerializer
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
