class Project < ActiveRecord::Base
  validates :name

  belongs_to :competition, inverse_of: :projects
  has_and_belongs_to_many :collaborators, class_name: 'User', inverse_of: :projects
  has_many :comments, inverse_of: :project
end
