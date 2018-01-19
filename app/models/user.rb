class User < ApplicationRecord
  has_many :saved_drinks
  # accepts_nested_attributes_for :ingredients
end
