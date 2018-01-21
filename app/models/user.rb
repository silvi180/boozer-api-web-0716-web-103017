class User < ApplicationRecord
  has_secure_password
  has_many :saved_drinks
  accepts_nested_attributes_for :saved_drinks

  validates_uniqueness_of :username
  validates :firstname, :lastname, :email, :age, presence: true
  validates :password, length: { minimum: 8 }, on: :create
end
