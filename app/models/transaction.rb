class Transaction < ActiveRecord::Base
  belongs_to :sender, polymorphic: true
  belongs_to :recipient, polymorphic: true

  validates :amount, presence: true, numericality: { greater_than: 0 }
end
