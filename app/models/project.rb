class Project < ActiveRecord::Base
  validates :name, :blurb, :description, presence: true

  has_and_belongs_to_many :users
end
