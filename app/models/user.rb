class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :timeoutable, :recoverable,
    :rememberable, :trackable, :validatable, :lockable

  has_and_belongs_to_many :projects, inverse_of: :collaborators
  belongs_to :role, inverse_of: :users
end
