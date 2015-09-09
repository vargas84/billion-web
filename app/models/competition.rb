class Competition < ActiveRecord::Base
  has_many :projects, inverse_of: :competition, dependent: :destroy
  has_many :transactions, inverse_of: :competition, dependent: :destroy

  # TODO: Add validations to ensure only 1 competition per time period
  # TODO: validate that end_date > start_date
  validates :code_name, :start_date, :end_date, presence: true

  def self.current_competition
    find_by('start_date < :now and end_date > :now', now: Time.now)
  end
end
