class Competition < ActiveRecord::Base
  has_many :projects, inverse_of: :competition
end