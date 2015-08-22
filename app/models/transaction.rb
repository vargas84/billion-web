class Transaction < ActiveRecord::Base
  belongs_to :sender, polymorphic: true
  belongs_to :recipient, polymorphic: true
  belongs_to :competition, inverse_of: :transactions

  TYPES = %w(Project TempUser)

  validates :sender_type, inclusion: { in: TYPES, allow_nil: true }
  validates :recipient_type, inclusion: { in: TYPES }
  validates :amount, numericality: { greater_than: 0.0 }
  validates :points, numericality: { greater_than: 0 }
end
