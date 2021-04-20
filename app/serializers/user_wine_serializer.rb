class UserWineSerializer
  include FastJsonapi::ObjectSerializer
  attributes :wine_id, :user_id, :comment
end
