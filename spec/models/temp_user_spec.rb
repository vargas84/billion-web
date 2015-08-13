require 'rails_helper'

RSpec.describe TempUser, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should allow_value(Faker::Internet.email).for(:email) }
    it { should_not allow_value(Faker::Lorem.word).for(:email) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:sent_transactions) }
    it { is_expected.to have_many(:received_transactions) }
  end
end
