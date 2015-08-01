class Project < ActiveRecord::Base
  validates :name, presence: true

  belongs_to :competition, inverse_of: :projects

  has_many :memberships, inverse_of: :project
  has_many :collaborators, through: :memberships, source: :user, inverse_of: :projects
  has_many :comments, inverse_of: :project, dependent: :destroy
end
