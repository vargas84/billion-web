require 'rails_helper'

describe Match, type: :model do
  subject { build :match }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:round) }
    it { is_expected.to validate_presence_of(:project_1) }
    it { is_expected.to validate_presence_of(:project_2) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:round).inverse_of(:matches) }

    it do
      is_expected.to belong_to(:project_1)
        .class_name('Project')
        .inverse_of(:matches_as_1)
    end

    it do
      is_expected.to belong_to(:project_2)
        .class_name('Project')
        .inverse_of(:matches_as_2)
    end
  end
end
