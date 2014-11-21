class User < ActiveRecord::Base
  before_save {|user| user.email=user.email.downcase}

  has_many :comments
  has_many :memberships
  has_many :projects, through: :memberships

  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  has_secure_password

  def full_name
    "#{first_name} #{last_name}"
  end

end
