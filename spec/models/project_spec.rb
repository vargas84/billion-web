require 'rails_helper'

describe Project, type: :model do
  subject { build :project }

  describe 'validations' do
    it { should validate_presence_of(:name) }

    it 'should validate uniqueness of competitor' do
      existing_project = create :project, :with_competitor
      project = build :project

      expect { project.competitor = existing_project }.to change { project.valid? }
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

  describe '#points_donated' do
    it 'returns the total points donated to a project' do
      project = create :project

      create :transaction, recipient: project, points: 100
      create :transaction, recipient: project, points: 20
      create :transaction, sender: project, points: 50

      expect(project.points_donated).to eq(120)
    end
  end

  describe '#donation_count' do
    it 'returns the total number of donations to a project' do
      project = create :project

      create :transaction, recipient: project
      create :transaction, sender: project

      expect(project.donation_count).to eq(1)
    end
  end

  describe '#points_per_donation' do
    it 'returns the average number of points per donation' do
      project = create :project

      create :transaction, recipient: project, points: 10
      create :transaction, recipient: project, points: 20
      create :transaction, sender: project, points: 10

      expect(project.points_per_donation).to eq(15)
    end

    it 'protects against divide by zero' do
      project = create :project
      expect(project.points_per_donation).to eq(0)
    end
  end
end
