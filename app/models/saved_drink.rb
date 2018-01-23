class SavedDrink < ApplicationRecord
  belongs_to :cocktail
  belongs_to :user
  has_many :proportions, through: :cocktail
  has_many :adjusted_proportions
  has_many :ingredients, through: :adjusted_proportions
end
