class Round < ActiveRecord::Base
  belongs_to :competition, inverse_of: :rounds
  has_many :matches, inverse_of: :round, dependent: :destroy

  validates :competition, presence: true
  validates :round_number, presence: true
  validates :started_at, presence: true
  validates :ended_at, presence: true
end
