require 'rails_helper'

describe Project, type: :model do
  subject { build :project }

  describe 'validations' do
    it { should validate_presence_of(:name) }

    it 'should validate uniqueness of competitor' do
      existing_project = create :project, :with_competitor
      project = build :project

      expect{ project.competitor = existing_project }.to change{ project.valid? }
        .from(true).to(false)
    end

    it 'should allow competitor to be nil' do
      project = build :project

      expect(project.valid?).to eq(true)
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:competition).inverse_of(:projects) }
    it { is_expected.to belong_to(:competitor).class_name('Project') }
    it { is_expected.to have_many(:sent_transactions).class_name('Transaction') }

    it do
      is_expected.to have_many(:received_transactions)
        .class_name('Transaction')
    end

    it do
      is_expected.to have_many(:comments)
        .inverse_of(:project)
        .dependent(:destroy)
    end

    it do
      is_expected.to have_many(:collaborators)
        .through(:memberships)
        .source(:user)
    end

    it do
      is_expected.to have_many(:memberships)
        .inverse_of(:project)
        .dependent(:destroy)
    end
  end

  describe 'before_create' do
    describe 'set_competitor_inverse' do
      it "sets competitor's competitor to self" do
        project = build :project, :with_competitor
        competitor = project.competitor

        expect(competitor.competitor).to be_nil

        project.save

        expect(competitor.competitor).to be(project)
      end
    end
  end
end
