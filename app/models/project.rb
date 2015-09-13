class Project < ActiveRecord::Base
  extend FriendlyId
  friendly_id :short_name, use: :slugged

  belongs_to :competition, inverse_of: :projects
  belongs_to :competitor, class_name: 'Project'
  has_many :memberships, inverse_of: :project, dependent: :destroy
  has_many :collaborators, through: :memberships, source: :user
  has_many :comments, inverse_of: :project, dependent: :destroy
  has_many :sent_transactions, as: :sender, class_name: 'Transaction'
  has_many :received_transactions, as: :recipient, class_name: 'Transaction'

  validates :name, presence: true
  validates :competitor_id, uniqueness: true, allow_nil: true

  after_create :set_competitor_inverse, if: 'competitor.present?'

  def points_donated
    received_transactions.sum(:points)
  end

  def donation_count
    received_transactions.size
  end

  def points_per_donation
    return 0 if donation_count == 0
    points_donated / donation_count
  end

  private

  def set_competitor_inverse
    competitor.update_attribute :competitor, self
  end
end
