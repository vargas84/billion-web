class TempUser < ActiveRecord::Base
  has_many :sent_transactions, as: :sender, class_name: 'Transaction'
  has_many :received_transactions, as: :recipient, class_name: 'Transaction'

  validates :email, email: true, allow_blank: true, if: :in_person?
  validates :email, email: true, allow_blank: false, unless: :in_person?

  accepts_nested_attributes_for :sent_transactions
end
