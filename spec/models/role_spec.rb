require 'rails_helper'

describe Role, type: :model do
  subject { build :role }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
  describe 'associations' do
    it { is_expected.to have_many(:users).inverse_of(:role) }
  end
end
