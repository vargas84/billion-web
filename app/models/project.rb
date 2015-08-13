class Project < ActiveRecord::Base
  belongs_to :competition, inverse_of: :projects

  has_many :memberships, inverse_of: :project
  has_many :collaborators, through: :memberships, source: :user, inverse_of: :projects
  has_many :comments, inverse_of: :project, dependent: :destroy
  has_many :sent_transactions, as: :sender, class_name: 'Transaction'
  has_many :received_transactions, as: :recipient, class_name: 'Transaction'

  validates :name, presence: true
end
