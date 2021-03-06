class UserWine < ApplicationRecord
  belongs_to :wine
  validates :user_id, presence: true

  def self.for_user_dashboard(user_id)
    joins(:wine)
      .where(user_id: user_id)
      .select('user_wines.id, wines.api_id, wines.name, user_wines.comment')
  end
end
