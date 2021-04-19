class WineSearchResultSerializer
  include FastJsonapi::ObjectSerializer
  set_id :api_id
  attributes :api_id, :name, :vintage, :area
end
