require 'rails_helper'

RSpec.describe TempUser, type: :model do
  describe 'validations' do
    it { is_expected.to allow_value(Faker::Internet.email).for(:email) }
    it { is_expected.not_to allow_value(Faker::Lorem.word).for(:email) }
    it { is_expected.not_to allow_value('').for(:email) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:sent_transactions) }
    it { is_expected.to have_many(:received_transactions) }
  end
end
