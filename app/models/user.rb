class User < ActiveRecord::Base
  has_many :posts
  before_create :create_remember_token
  has_secure_password

  def self.new_remember_token #class method
    SecureRandom.urlsafe_base64
  end

  def self.encrypt(token) #class method
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

  def create_remember_token #calling class methods inside and instance method
    self.remember_token = User.encrypt(User.new_remember_token)
  end

end
