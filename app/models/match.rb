class Match < ActiveRecord::Base
  belongs_to :round, inverse_of: :matches
  belongs_to :project_1, class_name: 'Project', inverse_of: :matches_as_1
  belongs_to :project_2, class_name: 'Project', inverse_of: :matches_as_2

  validates :round, presence: true
  validates :project_1, presence: true
  validates :project_2, presence: true
end
