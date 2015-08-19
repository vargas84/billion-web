class Transaction < ActiveRecord::Base
  belongs_to :sender, polymorphic: true
  belongs_to :recipient, polymorphic: true

  TYPES = %w(Project User)

  validates :sender_type, inclusion: { in: TYPES }
  validates :recipient_type, inclusion: { in: TYPES }
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
