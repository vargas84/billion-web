require 'rails_helper'

describe User, type: :model do
  subject { build :user }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:encrypted_password) }

    it { is_expected.to have_attached_file(:profile_image) }
    # rubocop:disable Metrics/LineLength
    it { is_expected.to validate_attachment_content_type(:profile_image).allowing('image/jpeg', 'image/png', 'image/gif') }
  end
  describe 'associations' do
    it { is_expected.to belong_to(:role).inverse_of(:users) }
  end
end
