class CreateSavedDrinks < ActiveRecord::Migration[5.0]
  def change
    create_table :saved_drinks do |t|
      t.string :name
      t.string :description
      t.string :instructions
      t.string :source
      t.references :cocktail, foreign_key: true
      t.references :user, foreign_key: true
    end
  end
end
