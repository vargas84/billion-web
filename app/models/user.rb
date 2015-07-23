class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :timeoutable, :recoverable,
    :rememberable, :trackable, :validatable, :lockable

  belongs_to :role, inverse_of: :users

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :encrypted_password, presence: true

  has_attached_file :profile_image,
    styles: { medium: '300x300>', thumb: '100x100>' },
    default_url: 'images/:style/missing.png'
  validates_attachment_content_type :profile_image, content_type: /\Aimage\/.*\Z/
end
