class Competition < ActiveRecord::Base
  validates :code_name, :start_date, :end_date, presence: true

  has_many :projects, inverse_of: :competition, dependent: :destroy
end
