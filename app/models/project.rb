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

  # TODO: spec for scopes

  scope :active, -> { where(eliminated_at: nil) }

  scope :order_by_points, lambda {
    select('projects.*, sum(points) as points')
      .joins('LEFT JOIN transactions ON projects.id = transactions.recipient_id ')
      .where('transactions.recipient_type = \'Project\' OR transactions.recipient_type IS NULL')
      .order('points DESC NULLS LAST')
      .group('projects.id')
  }

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

  def eliminated?
    eliminated_at.present?
  end

  private

  def set_competitor_inverse
    competitor.update_attribute :competitor, self
  end
end
