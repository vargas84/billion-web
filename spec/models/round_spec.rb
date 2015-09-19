require 'rails_helper'

describe Round, type: :model do
  subject { build :round }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:competition) }
    it { is_expected.to validate_presence_of(:round_number) }
    it { is_expected.to validate_presence_of(:started_at) }
    it { is_expected.to validate_presence_of(:ended_at) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:competition).inverse_of(:rounds) }

    it do
      is_expected.to have_many(:matches)
        .inverse_of(:round)
        .dependent(:destroy)
    end
  end
end
