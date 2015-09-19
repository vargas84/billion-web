class Round < ActiveRecord::Base
  belongs_to :competition, inverse_of: :rounds

  validates :competition, presence: true
  validates :started_at, presence: true
  validates :ended_at, presence: true
end
