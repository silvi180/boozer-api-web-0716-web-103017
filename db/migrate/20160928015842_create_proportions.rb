class CreateProportions < ActiveRecord::Migration[5.0]
  def change
    create_table :proportions do |t|
      t.string :amount
      t.references :cocktail, foreign_key: true
      t.references :ingredient, foreign_key: true
    end
  end
end
