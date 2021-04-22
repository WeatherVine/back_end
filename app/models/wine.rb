class Wine < ApplicationRecord
  has_many :user_wines, dependent: :destroy
  validates :api_id, uniqueness: true, presence: true
  validates :name, presence: true
end
