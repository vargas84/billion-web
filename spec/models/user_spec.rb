require 'rails_helper'

describe User, type: :model do
  subject(:user) { build :user }

  describe 'validations' do
    it { is_expected.to have_attached_file(:profile_image) }

    it do
      is_expected.to validate_attachment_content_type(:profile_image)
        .allowing('image/jpeg', 'image/png', 'image/gif')
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:role).inverse_of(:users) }
    it { is_expected.to have_many(:projects).through(:memberships) }

    it do
      is_expected.to have_many(:memberships)
        .inverse_of(:user)
        .dependent(:destroy)
    end
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

  describe '#full_name' do
    its(:full_name) { is_expected.to eq("#{user.first_name} #{user.last_name}") }
  end
end
