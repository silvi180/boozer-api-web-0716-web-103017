class CreateCocktails < ActiveRecord::Migration[5.0]
  def change
    create_table :cocktails do |t|
      t.string :name
      t.string :description
      t.string :instructions
      t.string :source
    end
  end
end
