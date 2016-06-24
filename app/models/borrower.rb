class Borrower < ActiveRecord::Base
  has_secure_password
  has_many :joins
  has_many :lenders, through: :joins
  validates :email, :password, :password_confirmation, :first_name, :last_name, :amount_needed, :description, :need, presence: true
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :email, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
end
