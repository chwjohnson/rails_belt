class User < ActiveRecord::Base
  has_secure_password
  has_many :posts
  has_many :likes
  validates :password, length: { minimum: 8 }
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :name, :alias, :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  
end
