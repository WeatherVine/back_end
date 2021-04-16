class UserWine < ApplicationRecord
  belongs_to :wine
  validates_presence_of :user_id
end
