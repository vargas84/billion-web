class Comment < ActiveRecord::Base
  belongs_to :project, inverse_of: :comments
end