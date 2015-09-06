require 'rails_helper'

describe TempUser, type: :model do
  subject { build :temp_user }

  describe 'validations' do
    it { is_expected.to allow_value(Faker::Internet.email).for(:email) }
    it { is_expected.not_to allow_value(Faker::Lorem.word).for(:email) }

    context 'in person temp user' do
      subject { build :temp_user, :in_person }

      it { is_expected.to allow_value(nil).for(:email) }
      it { is_expected.to allow_value('').for(:email) }
    end

    context 'on web temp user' do
      subject { build :temp_user, :on_web }

      it { is_expected.to_not allow_value(nil).for(:email) }
      it { is_expected.to_not allow_value('').for(:email) }
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:sent_transactions) }
    it { is_expected.to have_many(:received_transactions) }
  end

  describe 'nested attributes' do
    it { is_expected.to accept_nested_attributes_for(:sent_transactions) }
  end

  describe 'defaults' do
    its(:in_person) { is_expected.to eq(false) }
  end
end
