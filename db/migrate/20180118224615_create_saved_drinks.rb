class CreateSavedDrinks < ActiveRecord::Migration[5.0]
  def change
    create_table :saved_drinks do |t|
      t.integer :cocktail_id
      t.integer :user_id
      t.string :name
      t.string :description
      t.string :instruction
      t.string :ingredients
      t.string :source
    end
  end
end
