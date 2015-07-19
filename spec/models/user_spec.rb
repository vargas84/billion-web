require 'rails_helper'

describe User, type: :model do
  subject { build :user }

  describe 'associations' do
    it { is_expected.to belong_to(:role).inverse_of(:users) }
  end
end
