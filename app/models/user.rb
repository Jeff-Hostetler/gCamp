class User < ActiveRecord::Base
  before_save {|user| user.email=user.email.downcase}

  validates :email, presence: true, uniqueness: true
  has_secure_password

end
