class User < ApplicationRecord

  has_secure_password
  # Generate API Token
  before_create do |user|
    user.api_token = user.generate_auth_token
  end
  validates_uniqueness_of :email,:api_token
  validates_presence_of :name,:email

  has_many :short_urls
  def generate_auth_token
    loop do
      token =  SecureRandom.uuid.gsub(/\-/,"")
      break token unless User.exists?(api_token: token)
    end
  end
end