class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :timeoutable, :recoverable,
    :rememberable, :trackable, :validatable, :lockable

  has_many :memberships, inverse_of: :user
  has_many :projects, through: :memberships, inverse_of: :collaborators
  belongs_to :role, inverse_of: :users

  def admin?
    role_id == 2
  end
end
