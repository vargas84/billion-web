require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'validations' do
    it { is_expected.to validate_numericality_of(:amount).is_greater_than(0.0).allow_nil }
    it { is_expected.to validate_inclusion_of(:recipient_type).in_array(%w(Project TempUser)) }
    it { is_expected.to validate_numericality_of(:points).is_greater_than(0) }

    it do
      is_expected.to validate_inclusion_of(:sender_type)
        .in_array(%w(Project TempUser))
        .allow_nil
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:sender) }
    it { is_expected.to belong_to(:recipient) }
    it { is_expected.to belong_to(:competition).inverse_of(:transactions) }
  end
end
