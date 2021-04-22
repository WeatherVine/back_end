class UserDashboardSerializer
  include FastJsonapi::ObjectSerializer
  set_type 'favorite_wine'
  attributes :name, :comment

  attribute :api_id do |dashboard_wine|
    dashboard_wine.api_id.to_s
  end
end
