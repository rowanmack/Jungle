class User < ApplicationRecord

  has_secure_password

  validates :name, presence: true
  validates :email, presence: true
  validates_uniqueness_of :email, case_sensitive: false
  validates :password, presence: true, :length => {:within => 6..40}
  validates :password_confirmation, presence: true

 
  def self.authenticate_with_credentials email, password
    email = email.downcase.strip
    user = User.find_by_email(email)
      if user && user.authenticate(password)
        return user
      end 
    return nil
  end
end
