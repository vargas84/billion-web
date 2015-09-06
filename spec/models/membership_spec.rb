require 'rails_helper'

describe Membership, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user).inverse_of(:memberships) }
    it { is_expected.to belong_to(:project).inverse_of(:memberships) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:project) }
  end
end
