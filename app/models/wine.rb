class Wine < ApplicationRecord
  has_many :user_wines
  validates_uniqueness_of :api_id
  validates_presence_of :name
end
