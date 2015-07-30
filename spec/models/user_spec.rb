require 'rails_helper'

describe User, type: :model do
  subject { build :user }

  describe 'associations' do
    it { is_expected.to belong_to(:role).inverse_of(:users) }
  end

  describe '#admin?' do
    let(:admin) { build :admin }
    let(:user) { build :user }
    it 'is true for admin' do
      expect(admin).to be_admin
    end
    it 'is false for user' do
      expect(user).not_to be_admin
    end
  end
end
