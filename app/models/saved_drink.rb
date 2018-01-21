class SavedDrink < ApplicationRecord
  belongs_to :cocktail
  belongs_to :user
  has_many :proportions, through: :cocktail
  has_many :ingredients, through: :proportions
end
