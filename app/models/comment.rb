class Comment < ActiveRecord::Base
  validates :author, :content, :project, presence: true

  belongs_to :project, inverse_of: :comments
end
