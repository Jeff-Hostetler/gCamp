class User < ActiveRecord::Base
  before_save {|user| user.email=user.email.downcase}

  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  has_secure_password

end
